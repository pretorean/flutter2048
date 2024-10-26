part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameEmptyState extends GameState {}

class GameNextTurnState extends GameState {
  final Board board;

  const GameNextTurnState({
    required this.board,
  });

  @override
  List<Object> get props => [board];
}
