import 'dart:math';
import 'dart:ui';

import 'package:block_breaker/game/component/block.dart' as b;
import 'package:block_breaker/game/component/paddle.dart';
import 'package:block_breaker/game/component/position_converter.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ball extends CircleComponent with CollisionCallbacks, PositionConverter {
  static const double _ballSpeed = 500;

  Ball(
    double radius,
    Color color,
  ) : super(
          radius: radius,
          paint: Paint()..color = color,
        ) {
    final vx = _ballSpeed * cos(_getInitialAngle() * pi / 180);
    final vy = _ballSpeed * sin(_getInitialAngle() * pi / 180);
    velocity = Vector2(vx, vy);
  }

  late Vector2 velocity;

  @override
  Future<void> onLoad() async {
    await add(CircleHitbox(radius: radius));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ScreenHitbox) {
      final paddleRect = other.toAbsoluteRect();
      _handleCollisionWithScreen(intersectionPoints, paddleRect);
    } else if (other is Paddle) {
      final paddleRect = other.toAbsoluteRect();
      _handleCollisionWithBox(intersectionPoints, paddleRect);
    } else if (other is b.Block) {
      final blockRect = other.toAbsoluteRect();
      _handleCollisionWithBox(intersectionPoints, blockRect);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  double _getInitialAngle() {
    final double random = Random().nextDouble();
    return lerpDouble(0, 360, random) ?? 45;
  }

  void _handleCollisionWithBox(Set<Vector2> intersectionPoints, Rect boxRect) {
    bool isXCollided = false;
    bool isYCollided = false;
    for (final point in intersectionPoints) {
      int px = point.x.toInt();
      int py = point.y.toInt();
      if (px == boxRect.left.toInt() || px == boxRect.right.toInt()) {
        isXCollided = true;
      }
      if (py == boxRect.top.toInt() || py == boxRect.bottom.toInt()) {
        isYCollided = true;
      }
    }
    if (isXCollided) {
      velocity.x *= -1;
    }
    if (isYCollided) {
      velocity.y *= -1;
    }
  }

  void _handleCollisionWithScreen(
    Set<Vector2> intersectionPoints,
    Rect screenRect,
  ) {
    for (final point in intersectionPoints) {
      int px = point.x.toInt();
      int py = point.y.toInt();
      if (px == screenRect.left.toInt() && velocity.x < 0) {
        velocity.x *= -1;
      }
      if (px == screenRect.right.toInt() && velocity.x > 0) {
        velocity.x *= -1;
      }
      if (py == screenRect.top.toInt() && velocity.y < 0) {
        velocity.y *= -1;
      }
      if (py >= screenRect.bottom.toInt()) {
        removeFromParent();
      }
    }
  }
}
