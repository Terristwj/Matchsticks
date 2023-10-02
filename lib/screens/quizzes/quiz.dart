import 'package:flutter/material.dart';
import 'package:matchsticks/screens/quizzes/question_screen.dart';
import 'package:matchsticks/screens/quizzes/results_screen.dart';
import 'package:matchsticks/screens/quizzes/start_screen.dart';
import 'package:matchsticks/widgets/home_screen/appbar.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  String activeScreen = "start_screen";

  void startQuiz() {
    selectedAnswers = [];
    setState(() {
      activeScreen = "question_screen";
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
  }

  void displayResults() {
    setState(() {
      activeScreen = "results_screen";
    });
  }

  void returnHome() {
    setState(() {
      activeScreen = "start_screen";
    });
  }

  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

  // void switchScreen() {
  //   setState(() {
  //     activeScreen = const QuestionScreen();
  //   });
  // }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(onExit: startQuiz);

    if (activeScreen == "start_screen") {
      screenWidget = StartScreen(onExit: startQuiz);
    } else if (activeScreen == "question_screen") {
      screenWidget = QuestionScreen(
        onExit: displayResults,
        onSelectedAnswer: chooseAnswer,
      );
    } else if (activeScreen == "results_screen") {
      screenWidget = ResultsScreen(
        onHome: returnHome,
        onRestart: startQuiz,
        chosenAnswers: selectedAnswers,
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.deepPurpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const CustomAppBar(isHome: false),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    screenWidget,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
