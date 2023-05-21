import 'dart:async';
import 'dart:ui';

import 'package:block_breaker/game/component/position_converter.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class Paddle extends RectangleComponent with CollisionCallbacks, DragCallbacks, PositionConverter {
  Paddle(
    double width,
    double height,
    Color color, [
    this.onDrag,
  ]) : super(
          size: Vector2(width, height),
          paint: Paint()..color = color,
        );
  final void Function(DragUpdateEvent event)? onDrag;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    onDrag?.call(event);
    super.onDragUpdate(event);
  }
}
