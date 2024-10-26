import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter2048/domain/board.dart';
import 'package:flutter2048/domain/board_size.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameEmptyState()) {
    on<GameEvent>(
      (event, emit) => switch (event) {
        GameStartEvent() => _gameStart(event, emit),
        GameStopEvent() => _gameStop(event, emit),
        MoveUpEvent(:final isAnimated) => _moveDirection(_Direction.up, emit, isAnimated: isAnimated),
        MoveDownEvent(:final isAnimated) => _moveDirection(_Direction.down, emit, isAnimated: isAnimated),
        MoveRightEvent(:final isAnimated) => _moveDirection(_Direction.right, emit, isAnimated: isAnimated),
        MoveLeftEvent(:final isAnimated) => _moveDirection(_Direction.left, emit, isAnimated: isAnimated),
      },
    );
  }

  void _gameStart(GameStartEvent event, Emitter<GameState> emit) {
    switch (state) {
      case GameEmptyState():
        emit(GameNextTurnState(board: Board.create(size: event.boardSize)));
      case GameNextTurnState():
        emit(state);
    }
  }

  void _gameStop(GameStopEvent event, Emitter<GameState> emit) {
    switch (state) {
      case GameNextTurnState():
        emit(GameEmptyState());
      case GameEmptyState():
        emit(state);
    }
  }

  void _moveDirection(
    _Direction direction,
    Emitter<GameState> emit, {
    required bool isAnimated,
  }) {
    final state = this.state;
    if (state is! GameNextTurnState) return;

    final (isMoved, array) = _moveDirectionArray(direction, state.board);
    if (isMoved) {
      emit(GameNextTurnState(board: Board(state.board.size, array)));
      final event = switch (direction) {
        _Direction.up => MoveUpEvent(isAnimated: true),
        _Direction.down => MoveDownEvent(isAnimated: true),
        _Direction.left => MoveLeftEvent(isAnimated: true),
        _Direction.right => MoveRightEvent(isAnimated: true),
      };
      Future<void>.delayed(const Duration(milliseconds: 10)).then((_) => add(event));
    } else if (isAnimated) {
      emit(GameNextTurnState(board: Board(state.board.size, Board.seedArray(array))));
    }
  }

  (bool, BoardArray) _moveDirectionArray(_Direction direction, Board board) {
    final size = board.size;
    final array = Board.copyArray(board.array);

    late final List<int> xIndexList;
    late final List<int> yxIndexList;
    switch (direction) {
      case _Direction.up:
        xIndexList = List.generate(size.width, (index) => index);
        yxIndexList = List.generate(size.height, (index) => index);
      case _Direction.down:
        xIndexList = List.generate(size.width, (index) => index);
        yxIndexList = List.generate(size.height, (index) => (size.height - 1) - index);
      case _Direction.left:
        xIndexList = List.generate(size.width, (index) => index);
        yxIndexList = List.generate(size.height, (index) => index);
      case _Direction.right:
        xIndexList = List.generate(size.width, (index) => (size.width - 1) - index);
        yxIndexList = List.generate(size.height, (index) => index);
    }

    var isMoved = false;
    if (direction.isVertical) {
      for (final x in xIndexList) {
        for (final y in yxIndexList) {
          _moveCell(
            direction: direction,
            x: x,
            y: y,
            array: array,
            onSetIsMoved: () => isMoved = true,
          );
        }
      }
    } else {
      for (final y in yxIndexList) {
        for (final x in xIndexList) {
          _moveCell(
            direction: direction,
            x: x,
            y: y,
            array: array,
            onSetIsMoved: () => isMoved = true,
          );
        }
      }
    }

    return (isMoved, array);
  }

  void _moveCell({
    required _Direction direction,
    required int x,
    required int y,
    required BoardArray array,
    required VoidCallback onSetIsMoved,
  }) {
    final cell = array[y][x];
    if (cell == 0) return;

    final nearIndex = switch (direction) {
      _Direction.up => y - 1,
      _Direction.down => y + 1,
      _Direction.left => x - 1,
      _Direction.right => x + 1,
    };

    if (direction.isVertical) {
      if (nearIndex < 0 || nearIndex > array.length - 1) return;
    } else {
      if (nearIndex < 0 || nearIndex > array[0].length - 1) return;
    }

    final nearCell = switch (direction) {
      _ when direction.isVertical => array[nearIndex][x],
      _ => array[y][nearIndex],
    };

    if (nearCell == 0) {
      array[y][x] = 0;
      if (direction.isVertical) {
        array[nearIndex][x] = cell;
      } else {
        array[y][nearIndex] = cell;
      }
      onSetIsMoved();
      return;
    }

    if (nearCell == cell) {
      array[y][x] = 0;
      if (direction.isVertical) {
        array[nearIndex][x] = cell + cell;
      } else {
        array[nearIndex][x] = cell + cell;
      }
      onSetIsMoved();
      return;
    }
  }
}

enum _Direction {
  up,
  down,
  left,
  right;

  bool get isVertical => [up, down].contains(this);
}
