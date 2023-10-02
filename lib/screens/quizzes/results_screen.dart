import 'package:flutter/material.dart';
import 'package:matchsticks/data/questions.dart';
import 'package:matchsticks/widgets/quizzes/results_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.onHome,
    required this.onRestart,
    required this.chosenAnswers,
  });

  final void Function() onHome;
  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      var question = questions[i];
      summary.add({
        "index": i,
        "question": question.question,
        "correct_answer": question.answers[0],
        "user_answer": chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((question) {
      return question['correct_answer'] == question['user_answer'];
    }).length;

    return SingleChildScrollView(
      child: SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You've answered $numCorrectQuestions out of $numTotalQuestions correctly!",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Answers & Questions
            ResultsSummary(summaryData),

            const SizedBox(height: 20),

            // Buttons

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                  ),
                  child: const Text("Return to Home"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: onRestart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                  ),
                  child: const Text("Restart Quiz"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
