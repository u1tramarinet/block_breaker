class Blocks {
  final int nRow;
  final int nColumn;
  late final List<bool> lives;

  Blocks(this.nRow, this.nColumn) {
    lives = List.filled(nRow * nColumn, true);
  }

  /// row: [1 -> nRow]
  /// column: [1 -> nColumn]
  void setLive(int row, int column, bool live) {
    assert(1 <= row && row <= nRow);
    assert(1 <= column && column <= nColumn);
    lives[_getIndex(row, column)] = live;
  }

  bool getLive(int row, int column) {
    assert(1 <= row && row <= nRow);
    assert(1 <= column && column <= nColumn);
    return lives[_getIndex(row, column)];
  }

  int _getIndex(int row, int column) {
    return (row - 1) * nColumn + (column - 1);
  }
}
