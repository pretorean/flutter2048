import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter2048/bloc/game/game_bloc.dart';
import 'package:flutter2048/core/dependency/dependencies_scope.dart';
import 'package:flutter2048/core/localization/localization.dart';
import 'package:flutter2048/domain/board_size.dart';
import 'package:flutter2048/util/extension/board_size_extension.dart';
import 'package:flutter2048/widget/game/game_screen_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: BoardSize.values
              .mapIndexed(
                (index, e) => Padding(
                  padding: index == BoardSize.values.length ? EdgeInsets.zero : const EdgeInsets.only(bottom: 8),
                  child: OutlinedButton(
                    onPressed: () => _openGame(context, e),
                    child: Text(context.l10n.startGame(e.displayName)),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _openGame(BuildContext context, BoardSize boardSize) {
    final gameBlock = DependenciesScope.of(context).gameBloc;

    gameBlock.add(GameStartEvent(boardSize: boardSize));

    final route = MaterialPageRoute<void>(
      builder: (context) => const GameScreenWidget(),
    );
    Navigator.push(context, route);
  }
}
