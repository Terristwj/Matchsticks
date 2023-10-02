import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchsticks/model/quiz_question.dart';
import 'package:matchsticks/services/palm_service.dart';
import 'package:matchsticks/widgets/quizzes/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.onExit,
    required this.onSelectedAnswer,
    required this.questions,
  });

  final void Function() onExit;
  final void Function(String answer) onSelectedAnswer;
  final List<QuizQuestion> questions;

  @override
  State<QuestionScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionScreen> {
  final PaLMService openAIService = PaLMService();
  var currentQuestionIndex = 0;

  answerQuestion(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);

    if (currentQuestionIndex == widget.questions.length - 1) {
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
    String question = "";
    List<String> answers = [];
    String correctAnswer = "";
    String explanation = "";

    Future getQuestions() async {
      final questions =
          await openAIService.generateQuestionAndAnswers('Mathematics');
      print(questions);

      // setState(() {
      //   question = questions[0];
      //   answers = questions[1];
      //   correctAnswer = questions[2];
      //   explanation = questions[3];
      // });
    }

    getQuestions();

    final currentQuestions = widget.questions[currentQuestionIndex];

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
