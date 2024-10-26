import 'dart:math';

import 'package:flutter2048/domain/board_size.dart';

typedef BoardArray = List<List<int>>;

class Board {
  final BoardSize size;
  final BoardArray array;

  Board(this.size, BoardArray array) : array = copyArray(array);

  Board.create({required this.size}) : array = seedArray(_createArray(size));

  static BoardArray _createArray(BoardSize size) => List.generate(
        size.height,
        (row) => List.generate(size.width, (index) => 0).toList(),
      ).toList();

  static BoardArray copyArray(BoardArray other) => List.generate(
        other.length,
        (row) => List<int>.from(other[row]),
      ).toList();

  static BoardArray seedArray(BoardArray oldArray) {
    final freeSpaces = <_ArrayPosition>{};
    for (var y = 0; y < oldArray.length; y++) {
      for (var x = 0; x < oldArray[y].length; x++) {
        if (oldArray[y][x] == 0) {
          freeSpaces.add(_ArrayPosition(x: x, y: y));
        }
      }
    }

    if (freeSpaces.isEmpty) return oldArray;

    final random = Random();
    final array = copyArray(oldArray);

    if (freeSpaces.length == 1) {
      assert(array[freeSpaces.first.y][freeSpaces.first.x] == 0, 'seed non zero value');
      array[freeSpaces.first.y][freeSpaces.first.x] = 2;
      return array;
    }

    for (final index in [1, 2]) {
      final value = random.nextInt(freeSpaces.length);
      final position = freeSpaces.elementAt(value);

      assert(array[position.y][position.x] == 0, 'seed non zero value');
      array[position.y][position.x] = 2;
      freeSpaces.remove(position);
    }
    return array;
  }
}

class _ArrayPosition {
  final int x;
  final int y;

  _ArrayPosition({
    required this.x,
    required this.y,
  });
}
