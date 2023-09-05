import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/game_controller.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context) {
    GameController gameController = GameController.gameControllerInstance;

    return Center(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: gameController.shuffleCards.length,
        itemBuilder: (context, index) {
          //final card = gameController.shuffleCards[index];
          return InkWell(
            onTap: () {
              if (gameController.isFlipped[index] == false) {
                gameController.flipCard(index);
              }
            },
            child: Obx(() => Card(
                  color: gameController.isFlipped[index]
                      ? Colors.white
                      : Colors.blue,
                  child: Center(
                    child: gameController.isFlipped[index]
                        ? Text(gameController.shuffleCards[index].toString())
                        : Container(),
                  ),
                )),
          );
        },
      ),
    );
  }
}
