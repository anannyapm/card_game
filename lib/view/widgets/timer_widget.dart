import 'package:flip_game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameController gameController = GameController.gameControllerInstance;
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 60,
      ),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.timer,
                size: 35,
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(() => Text(
                    textAlign: TextAlign.center,
                    "${gameController.seconds} seconds",
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
