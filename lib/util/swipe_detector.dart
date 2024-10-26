import 'package:flutter/material.dart';

/// Detects user swipes.
class SwipeDetector extends StatefulWidget {
  /// How this gesture detector should behave during hit testing.
  final HitTestBehavior? behavior;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the user has swiped in a particular direction.
  final void Function(SwipeDirection direction, Offset offset)? onSwipe;

  /// Called when the user has swiped upwards.
  final void Function(Offset offset)? onSwipeUp;

  /// Called when the user has swiped downwards.
  final void Function(Offset offset)? onSwipeDown;

  /// Called when the user has swiped to the left.
  final void Function(Offset offset)? onSwipeLeft;

  /// Called when the user has swiped to the right.
  final void Function(Offset offset)? onSwipeRight;

  const SwipeDetector({
    required this.child,
    super.key,
    this.behavior,
    this.onSwipe,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
  });

  @override
  State createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  late Offset _startPosition;
  late Offset _updatePosition;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      behavior: widget.behavior,
      onPanStart: (details) {
        _startPosition = details.globalPosition;
      },
      onPanUpdate: (details) {
        _updatePosition = details.globalPosition;
      },
      onPanEnd: (details) {
        _calculateAndExecute();
      },
      child: widget.child,
    );
  }

  void _calculateAndExecute() {
    final offset = _updatePosition - _startPosition;
    final direction = _getSwipeDirection(offset);

    widget.onSwipe?.call(
      direction,
      offset,
    );

    switch (direction) {
      case SwipeDirection.up:
        widget.onSwipeUp?.call(offset);
      case SwipeDirection.down:
        widget.onSwipeDown?.call(offset);
      case SwipeDirection.left:
        widget.onSwipeLeft?.call(offset);
      case SwipeDirection.right:
        widget.onSwipeRight?.call(offset);
    }
  }

  SwipeDirection _getSwipeDirection(
    Offset offset,
  ) {
    if (offset.dx.abs() > offset.dy.abs()) {
      if (offset.dx > 0) {
        return SwipeDirection.right;
      } else {
        return SwipeDirection.left;
      }
    } else {
      if (offset.dy > 0) {
        return SwipeDirection.down;
      } else {
        return SwipeDirection.up;
      }
    }
  }
}

/// The direction in which the user swiped.
enum SwipeDirection {
  /// Swipe up.
  up,

  /// Swipe down.
  down,

  /// Swipe left.
  left,

  /// Swipe right.
  right,
}
