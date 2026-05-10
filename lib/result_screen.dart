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
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $numberOfCorrectAnswers out of $totalNumberOfQuestions correctly!",
            ),
            SizedBox(height: 30),
            ...questions.asMap().entries.map((entry) {
              int index = entry.key;
              var question = entry.value;
              return SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuestionNumbers(index + 1),
                            SizedBox(width: 30),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Question(question.text),
                                  SizedBox(height: 10),
                                  Text(question.correctAnswer),
                                  SizedBox(height: 10),
                                  Text(
                                    answeredQuestions.values.toList()[index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
        ),
      ),
    );
  }
}
