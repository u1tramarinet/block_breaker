import 'dart:async';
import 'dart:ui';

import 'package:block_breaker/game/component/ball.dart';
import 'package:block_breaker/game/component/position_converter.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Block extends RectangleComponent
    with CollisionCallbacks, PositionConverter {
  Block(
    double width,
    double height,
    Color color,
  ) : super(
          size: Vector2(width, height),
          paint: Paint()..color = color,
        );

  @override
  FutureOr<void> onLoad() async {
    await add(RectangleHitbox(size: size));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball) {
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
