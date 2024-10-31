import 'package:flutter/material.dart';
import 'package:flutter2048/bloc/game/game_bloc.dart';
import 'package:flutter2048/core/dependency/dependencies_scope.dart';
import 'package:flutter2048/widget/game/base_game_widget.dart';
import 'package:flutter2048/widget/game/board_cell.dart';

const _minCellColor = Color(0x10F57F17);
const _maxCellColor = Color(0xaaF57F17);

final baseColors = <int, Color>{
  2: const Color(0xffeee4da),
  4: const Color(0xffede0c8),
  8: const Color(0xfff2b179),
  16: const Color(0xfff59563),
  32: const Color(0xfff67c5f),
  64: const Color(0xfff65e3b),
  128: const Color(0xffedcf72),
  256: const Color(0xffedcc61),
  512: const Color(0xffedc850),
  1024: const Color(0xffedc53f),
  2048: const Color(0xffedc22e),
};

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
                    children: row
                        .map(
                          (e) => Expanded(
                            child: BoardCell(
                              value: e,
                              color: e > 0 ? _calculateColor(e, state.board.maxValue) : null,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Color _calculateColor(int value, int maxValue) {
    const baseValue = 2048;

    if (value <= baseValue) return baseColors[value]?.withAlpha(0xB0) ?? _minCellColor;

    final t2 = value / maxValue;
    final t = t2.clamp(0.0, 1.0);
    return Color.lerp(_minCellColor, _maxCellColor, t) ?? _minCellColor;
  }
}


