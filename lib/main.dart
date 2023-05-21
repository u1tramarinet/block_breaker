import 'package:block_breaker/game/engine.dart';
import 'package:flutter/material.dart';

import 'screen/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Engine game = Engine();
    return MaterialApp(
      title: 'Block breaker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(
        game: game,
        onPlayPressed: game.reset,
      ),
    );
  }
}
