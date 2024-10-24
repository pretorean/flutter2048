import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter2048/domain/board_size.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameEmptyState()) {
    on<GameEvent>(
      (event, emit) => switch (event) {
        GameStartEvent() => _gameStart(event, emit),
        GameStopEvent() => _gameStop(event, emit),
      },
    );
  }

  void _gameStart(GameStartEvent event, Emitter<GameState> emit) {
    switch (state) {
      case GameEmptyState():
        emit(GameNextTurn(boardSize: event.boardSize));
      case GameNextTurn():
        emit(state);
    }
  }

  void _gameStop(GameStopEvent event, Emitter<GameState> emit) {
    switch (state) {
      case GameNextTurn():
        emit(GameEmptyState());
      case GameEmptyState():
        emit(state);
    }
  }
}
