import 'package:flame/game.dart';

abstract class PositionConverter {
  NotifyingVector2 get size;

  set position(Vector2 position);

  NotifyingVector2 get position;

  set cx(double cx) {
    position.x = cx - size.x / 2;
  }

  double get cx {
    return position.x + size.x / 2;
  }

  set cy(double cy) {
    position.y = cy - size.y / 2;
  }

  double get cy {
    return position.y + size.y / 2;
  }
}
