import "dart:math";

import "package:flutter/material.dart";
import 'package:matchsticks/widgets/lucky/lucky_roller.dart';
import 'package:matchsticks/widgets/lucky/lucky_text.dart';
import "package:matchsticks/widgets/home_screen/appbar.dart";

// Styling
const LinearGradient myLinearGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 247, 131, 168),
    Color.fromARGB(255, 253, 225, 234),
    Color.fromARGB(255, 231, 253, 225),
    Color.fromARGB(255, 231, 253, 225),
    Color.fromARGB(255, 225, 253, 250),
    Color.fromARGB(255, 131, 247, 250),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final randomizer = Random();

// Container Widget
class LuckyScreen extends StatefulWidget {
  const LuckyScreen({super.key});

  @override
  State<LuckyScreen> createState() {
    return _LuckyScreen();
  }
}

class _LuckyScreen extends State<LuckyScreen> {
  var currentDiceRoll = 2;

  void rollDice() {
    // SetState is required to re-render the widget
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFffaa5b),
          // gradient: myLinearGradient,
        ),
        child: Center(
          child: Column(
            children: [
              const CustomAppBar(isHome: false),
              const SizedBox(height: 200),
              const LuckyText("Test Your Luck!", 48),
              LuckyRoller(
                currentDiceRoll: currentDiceRoll,
                rollDice: rollDice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
