import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'dart:math';

import 'package:flame_audio/flame_audio.dart';

class Balloon extends SpriteComponent with TapCallbacks {
  final FlameGame gameRef;
  final Random _random = Random();
  late double speed;

  Balloon(this.gameRef) {
    size = Vector2(120, 100);
    anchor = Anchor.bottomCenter;
    speed = 150 + _random.nextDouble() * 100;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('b1.png');
    position = Vector2(_random.nextDouble() * gameRef.size.x, gameRef.size.y);
    await FlameAudio.audioCache.load('pop.mp3');
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(Vector2(0, -speed * dt));

    if (position.y + size.y < 0) {
      removeFromParent();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    FlameAudio.play('pop.mp3');
    removeFromParent();

    super.onTapDown(event);
  }
}
