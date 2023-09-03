import "package:flutter/material.dart";
import 'package:flutter_learnings/dice_roll_app/dice_roller.dart';
import 'package:flutter_learnings/dice_roll_app/my_text.dart';

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

// Container Widget
class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: myLinearGradient,
      ),
      child: const Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            MyText("Kon'nichiwa!", 48),
            SizedBox(height: 20),
            DiceRoller(),
          ])),
    );
  }
}
