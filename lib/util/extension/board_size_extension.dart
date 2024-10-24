import 'package:flutter2048/domain/board_size.dart';

extension BoardSizeExtension on BoardSize {
  String get displayName => switch (this) {
        BoardSize.square_3x3 => '3x3',
        BoardSize.square_4x4 => '4x4',
        BoardSize.square_5x5 => '5x5',
        BoardSize.square_6x6 => '6x6',
        BoardSize.square_7x7 => '7x7',
        BoardSize.square_8x8 => '8x8',
      };
}
