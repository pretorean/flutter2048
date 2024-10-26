import 'package:flutter/material.dart';
import 'package:flutter2048/bloc/game/game_bloc.dart';
import 'package:flutter2048/core/dependency/dependencies_scope.dart';
import 'package:flutter2048/util/extension/board_size_extension.dart';
import 'package:flutter2048/util/swipe_detector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BoardWidgetBuilder = Widget Function(BuildContext context, GameNextTurnState state);

class BaseGameWidget extends StatelessWidget {
  final VoidCallback onClose;
  final BoardWidgetBuilder boardWidgetBuilder;

  const BaseGameWidget({
    required this.onClose,
    required this.boardWidgetBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gameBlock = DependenciesScope.of(context).gameBloc;

    return BlocBuilder<GameBloc, GameState>(
      bloc: gameBlock,
      builder: (context, state) => switch (state) {
        GameEmptyState() => const SizedBox.shrink(),
        GameNextTurnState(:final board) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(board.size.displayName),
            ),
            body: SwipeDetector(
              onSwipe: (direction, _) {
                final event = switch (direction) {
                  SwipeDirection.up => MoveUpEvent(),
                  SwipeDirection.down => MoveDownEvent(),
                  SwipeDirection.left => MoveLeftEvent(),
                  SwipeDirection.right => MoveRightEvent(),
                };
                gameBlock.add(event);
              },
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: boardWidgetBuilder(context, state),
                  ),
                ),
              ),
            ),
          ),
      },
    );
  }
}
