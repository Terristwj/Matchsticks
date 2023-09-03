import "package:flutter/material.dart";
import 'package:flutter_learnings/dice_roll_app/my_container.dart';

void main() {
  runApp(
    const MyApp(),
  );
  // runApp(const MaterialApp(home: Text("Kon'nichiwa!")));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roll!',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Dice Roll!'),
        ),
        // backgroundColor: const Color.fromARGB(255, 253, 225, 234),
        body: const MyContainer(),
      ),
    );
  }
}
