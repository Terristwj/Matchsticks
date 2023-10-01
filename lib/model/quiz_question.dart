class QuizQuestion {
  const QuizQuestion(this.question, this.answers);

  final String question;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    // A copy of answers
    final shuffledList = List.of(answers);
    // Shuffle the copy
    shuffledList.shuffle();
    // Return the copy
    return shuffledList;
  }
}
