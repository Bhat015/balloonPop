import 'package:balloon_pop/balloon.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: BalloonPopGame()),
    );
  }
}

class BalloonPopGame extends FlameGame {
  late Timer _spawnTimer;
  double spawnInterval = 0.72;

  @override
  void onDispose() {
    FlameAudio.bgm.stop();
    super.onDispose();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    FlameAudio.bgm.play('bg.mp3', volume: 0.2);
    _spawnTimer = Timer(spawnInterval, repeat: true, onTick: spawnBalloon);
    _spawnTimer.start();
  }

  void spawnBalloon() {
    final balloon = Balloon(this);
    add(balloon);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spawnTimer.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = Colors.black,
    );
    super.render(canvas);
  }
}
