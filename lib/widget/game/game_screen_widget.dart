import 'package:flutter/material.dart';
import 'package:flutter2048/bloc/game/game_bloc.dart';
import 'package:flutter2048/core/dependency/dependencies_scope.dart';
import 'package:flutter2048/widget/game/base_game_widget.dart';
import 'package:flutter2048/widget/game/board_cell.dart';

class GameScreenWidget extends StatefulWidget {
  const GameScreenWidget({super.key});

  @override
  State<GameScreenWidget> createState() => _GameScreenWidgetState();
}

class _GameScreenWidgetState extends State<GameScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final gameBlock = DependenciesScope.of(context).gameBloc;

    return BaseGameWidget(
      onClose: () {
        gameBlock.add(GameStopEvent());
        Navigator.pop(context);
      },
      boardWidgetBuilder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: state.board.array
              .map(
                (row) => Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: row.map((e) => Expanded(child: BoardCell(value: e))).toList(),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
