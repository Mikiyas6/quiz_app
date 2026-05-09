class QuizQuestion {
  const QuizQuestion(this.text, this.answers, this.correctAnswer);

  final String text;
  final List<String> answers;
  final String correctAnswer;

  List<String> getShuffledAnswers() {
    List<String> shuffledList = List.of(
      answers,
    ); // creates a new copy of answers
    shuffledList.shuffle();
    return shuffledList;
  }
}
