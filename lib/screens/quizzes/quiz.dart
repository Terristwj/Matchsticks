import 'package:flutter/material.dart';
import 'package:matchsticks/model/quiz_question.dart';
import 'package:matchsticks/screens/quizzes/question_screen.dart';
import 'package:matchsticks/screens/quizzes/results_screen.dart';
import 'package:matchsticks/screens/quizzes/selection_screen.dart';
import 'package:matchsticks/widgets/home_screen/appbar.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<QuizQuestion> subjectQuestions = [];
  List<String> selectedAnswers = [];
  String activeScreen = "selection_screen";
  Color currentBackgroundColor = Color.fromARGB(255, 255, 99, 116);

  void selectSubject(List<QuizQuestion> questions, Color color) {
    selectedAnswers = [];
    setState(() {
      subjectQuestions = questions;
      activeScreen = "question_screen";
      currentBackgroundColor = color;
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
      activeScreen = "selection_screen";
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = SelectionScreen(onSubjectSelection: selectSubject);

    if (activeScreen == "selection_screen") {
      screenWidget = SelectionScreen(
        onSubjectSelection: selectSubject,
      );
    } else if (activeScreen == "question_screen") {
      screenWidget = QuestionScreen(
        onExit: displayResults,
        onSelectedAnswer: chooseAnswer,
        questions: subjectQuestions,
      );
    } else if (activeScreen == "results_screen") {
      screenWidget = ResultsScreen(
        onHome: returnHome,
        onRestart: selectSubject,
        questions: subjectQuestions,
        chosenAnswers: selectedAnswers,
        backgroundColor: currentBackgroundColor,
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              currentBackgroundColor,
              Color.fromARGB(255, 181, 181, 181),
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
                    const SizedBox(height: 100),
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
