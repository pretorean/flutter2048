import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BoardCell extends StatelessWidget {
  final int value;
  final Color? color;

  const BoardCell({
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        color: color,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: value > 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    _getText(),
                    style: const TextStyle(fontSize: 40),
                    maxLines: 1,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  String _getText() {
    if (value > 1000 * 1000) {
      final newValue = (value / (1024 * 1024)).round();
      return '${newValue}M';
    }

    if (value > 3 * 1000) {
      final newValue = (value / 1024).round();
      return '${newValue}K';
    }

    return '$value';
  }
}
