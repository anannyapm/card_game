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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Flip Memory Game",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        'Best Time: ${gameController.bestTime.value} seconds',
                        style: const TextStyle(fontSize: 18),
                      )),
                  IconButton(
                    onPressed: () => gameController.resetGame(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const TimerWidget(),
              const Expanded(child: GameGrid())
            ],
          ),
        ),
      ),
    );
  }
}
