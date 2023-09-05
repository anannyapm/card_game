import 'package:flip_game/controller/game_controller.dart';
import 'package:flip_game/view/widgets/game_grid.dart';
import 'package:flip_game/view/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GameController gameController = GameController.gameControllerInstance;
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              'Best Time: ${gameController.bestTime.value} seconds',
              style: const TextStyle(fontSize: 18),
            )),
        actions: [
          // Obx(() => IconButton(
          //       onPressed: () => gameController.isTimerActive
          //           ? gameController.stopTimer()
          //           : gameController.startTimer(),
          //       icon: gameController.isTimerActive
          //           ? const Icon(Icons.pause)
          //           : const Icon(Icons.play_arrow),
          //     )),
          IconButton(
            onPressed: () => gameController.resetGame(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [TimerWidget(), Expanded(child: GameGrid())],
        ),
      ),
    );
  }
}
