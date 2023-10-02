import 'package:flutter/material.dart';
import 'package:matchsticks/widgets/self_practices/lucky_text.dart';

class LuckyRoller extends StatelessWidget {
  const LuckyRoller({
    super.key,
    required this.currentDiceRoll,
    required this.rollDice,
  });

  final int currentDiceRoll;
  final void Function() rollDice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          "assets/images/lucky/dice-$currentDiceRoll.png",
          // width: 200,
          scale: 3,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 247, 237, 240),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
          ),
          child: const LuckyText("Roll Dice!", 20),
        ),
      ],
    );
  }
}
