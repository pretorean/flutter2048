import 'package:flutter/material.dart';
import 'package:flutter2048/bloc/game/game_bloc.dart';
import 'package:flutter2048/core/dependency/dependencies_scope.dart';
import 'package:flutter2048/util/extension/board_size_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseGameWidget extends StatelessWidget {
  final VoidCallback onClose;

  const BaseGameWidget({
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gameBlock = DependenciesScope.of(context).gameBloc;

    return BlocBuilder<GameBloc, GameState>(
      bloc: gameBlock,
      builder: (context, state) {
        return switch (state) {
          GameEmptyState() => const SizedBox.shrink(),
          GameNextTurn(:final boardSize) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Text(boardSize.displayName),
              ),
            ),
        };
      },
    );
  }
}
