import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question.dart';
import 'package:quiz_app/questionNumbers.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
    this.answeredQuestions, {
    required this.totalNumberOfQuestions,
    required this.resetQuiz,
    super.key,
  });
  final num totalNumberOfQuestions;
  final Map<num, String> answeredQuestions;
  final Function resetQuiz;

  @override
  Widget build(BuildContext context) {
    var numberOfCorrectAnswers = 0;
    answeredQuestions.forEach((key, value) {
      if (value == questions.elementAt(key.toInt()).correctAnswer) {
        numberOfCorrectAnswers += 1;
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You answered $numberOfCorrectAnswers out of $totalNumberOfQuestions correctly!",
        ),
        ...questions.asMap().entries.map((entry) {
          int index = entry.key;
          var question = entry.value;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  QuestionNumbers(index + 1),
                  SizedBox(width: 10),
                  Question(question.text),
                ],
              ),
              SizedBox(width: 10),
              Text(question.correctAnswer),
              SizedBox(width: 10),
              Text(answeredQuestions.values.toList()[index]),
            ],
          );
        }),
        SizedBox(height: 30),
        OutlinedButton.icon(
          label: Text("Restart Quiz"),
          style: IconButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 50),
            shape: RoundedRectangleBorder(),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            resetQuiz();
          },
          icon: Icon(Icons.redo_outlined),
        ),
      ],
    );
  }
}
