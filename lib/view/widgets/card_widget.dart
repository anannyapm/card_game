/* import 'package:flip_game/controller/game_controller.dart';
import 'package:flip_game/model/card_model.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;
  const CardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    GameController gameController = GameController.gameControllerInstance;

    return InkWell(
      onTap: () {
        if (!card.isFlipped) {
          gameController.flipCard(card);
        }
      },
      child: Card(
        color: card.isFlipped ? Colors.white : Colors.blue,
        child: Center(
          child: card.isFlipped? Text(card.id.toString())
              // ? Icon(
              //     Icons.memory,
              //     size: 48.0,
              //     color: card.isMatched ? Colors.green : Colors.white,
              //   )
              : Container(),
        ),
      ),
    );
    
  }
}
 */