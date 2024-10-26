import 'package:flutter/material.dart';

class BoardCell extends StatelessWidget {
  final int value;

  const BoardCell({
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all()),
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: value > 0 ? Text('$value') : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
