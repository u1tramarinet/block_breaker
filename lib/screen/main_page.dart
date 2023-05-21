import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.game,
    this.onPlayPressed,
  });

  final Game game;
  final void Function()? onPlayPressed;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Block breaker'),
        actions: [
          IconButton(
            onPressed: () {
              widget.onPlayPressed?.call();
            },
            icon: const Icon(Icons.play_arrow),
          )
        ],
      ),
      body: SafeArea(
        child: GameWidget(game: widget.game),
      ),
    );
  }
}
