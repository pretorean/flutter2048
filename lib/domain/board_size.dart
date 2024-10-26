enum BoardSize {
  square_3x3,
  square_4x4,
  square_5x5,
  square_6x6,
  square_7x7,
  square_8x8;

  int get width => switch (this) {
        BoardSize.square_3x3 => 3,
        BoardSize.square_4x4 => 4,
        BoardSize.square_5x5 => 5,
        BoardSize.square_6x6 => 6,
        BoardSize.square_7x7 => 7,
        BoardSize.square_8x8 => 8,
      };

  int get height => switch (this) {
        BoardSize.square_3x3 => 3,
        BoardSize.square_4x4 => 4,
        BoardSize.square_5x5 => 5,
        BoardSize.square_6x6 => 6,
        BoardSize.square_7x7 => 7,
        BoardSize.square_8x8 => 8,
      };
}
