import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchsticks/widgets/quizzes/answer_button.dart';
import 'package:matchsticks/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.onExit,
    required this.onSelectedAnswer,
  });

  final void Function() onExit;
  final void Function(String answer) onSelectedAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  answerQuestion(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);

    if (currentQuestionIndex == questions.length - 1) {
      setState(() {
        currentQuestionIndex = 0;
      });
      widget.onExit();
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestions = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestions.question,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestions.getShuffledAnswers().map((answer) {
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: const BoxConstraints(
                      minWidth: 300,
                      maxWidth: 600,
                    ),
                    child: AnswerButton(
                      answerText: answer,
                      onPressed: () {
                        answerQuestion(answer);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
