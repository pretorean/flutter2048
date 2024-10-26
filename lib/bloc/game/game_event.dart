part of 'game_bloc.dart';

sealed class GameEvent {
  const GameEvent();
}

class GameStartEvent extends GameEvent {
  final BoardSize boardSize;

  GameStartEvent({required this.boardSize});
}

class GameStopEvent extends GameEvent {}

class MoveUpEvent extends GameEvent {
  final bool isAnimated;

  MoveUpEvent({this.isAnimated = false});
}

class MoveDownEvent extends GameEvent {
  final bool isAnimated;

  MoveDownEvent({this.isAnimated = false});
}

class MoveRightEvent extends GameEvent {
  final bool isAnimated;

  MoveRightEvent({this.isAnimated = false});
}

class MoveLeftEvent extends GameEvent {
  final bool isAnimated;

  MoveLeftEvent({this.isAnimated = false});
}
