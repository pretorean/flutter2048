part of 'game_bloc.dart';

sealed class GameEvent {
  const GameEvent();
}

class GameStartEvent extends GameEvent {
  final BoardSize boardSize;

  GameStartEvent({required this.boardSize});
}

class GameStopEvent extends GameEvent {}
