part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameEmptyState extends GameState {}

class GameNextTurn extends GameState {
  final BoardSize boardSize;

  const GameNextTurn({required this.boardSize});

  @override
  List<Object> get props => [boardSize];
}
