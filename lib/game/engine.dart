import 'dart:math';

import 'package:block_breaker/game/component/ball.dart';
import 'package:block_breaker/game/component/block.dart';
import 'package:block_breaker/game/component/paddle.dart';
import 'package:block_breaker/game/data/blocks.dart';
import 'package:flame/collisions.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Engine extends FlameGame
    with HasCollisionDetection, HasDraggableComponents {
  static const int _nRow = 5;
  static const int _nColumn = 5;
  static const double screenPadding = 50;
  static const double blockPadding = 5;
  static const double paddleMaxVelocity = 10;

  final Blocks blocks = Blocks(_nRow, _nColumn);

  void reset() {
    children.clear();
    onLoad();
  }

  @override
  Future<void>? onLoad() async {
    add(ScreenHitbox());
    await resetBlocks();
    await resetPaddle();
    await resetBall();
  }

  Future<void> resetPaddle() async {
    final Paddle paddle = Paddle(100, 20, Colors.white, onPaddleDrag);
    paddle.cx = size.x / 2;
    paddle.cy = size.y - paddle.size.y / 2 - 50;
    await add(paddle);
  }

  Future<void> resetBall() async {
    final Ball ball = Ball(10, Colors.white);
    ball.cx = size.x / 2;
    ball.cy = size.y / 2;
    await add(ball);
  }

  Future<void> resetBlocks() async {
    double areaWidth = size.x - screenPadding * 2;
    double areaHeight = size.y / 3 - screenPadding;
    double blockWidth =
        (areaWidth - (blockPadding * (_nColumn - 1))) / _nColumn;
    double blockHeight = (areaHeight - (blockPadding * (_nRow - 1))) / _nRow;

    for (int r = 0; r < _nRow; r++) {
      for (int c = 0; c < _nColumn; c++) {
        if (blocks.getLive(r + 1, c + 1)) {
          Block block = Block(blockWidth, blockHeight, Colors.blue);
          block.position.x = screenPadding + blockWidth * c + blockPadding * c;
          block.position.y = screenPadding + blockHeight * r + blockPadding * r;
          add(block);
        }
      }
    }
  }

  void onPaddleDrag(DragUpdateEvent event) {
    final paddle = children.whereType<Paddle>().first;
    double newPaddleX = paddle.position.x + min(event.delta.x, paddleMaxVelocity);

    if (newPaddleX < 0) {
      paddle.position.x = 0;
    } else if (size.x < newPaddleX + paddle.size.x) {
      paddle.position.x = size.x - paddle.size.x;
    } else {
      paddle.position.x = newPaddleX;
    }
  }
}
