import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question.dart';
import 'package:quiz_app/questionNumbers.dart';
import 'package:google_fonts/google_fonts.dart';

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
              textAlign: TextAlign.center,
              "You answered $numberOfCorrectAnswers out of $totalNumberOfQuestions questions correctly!",
              style: GoogleFonts.lato(fontSize: 17, color: Colors.white),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...questions.asMap().entries.map((entry) {
                      int index = entry.key;
                      var question = entry.value;
                      var answer = answeredQuestions.values.toList()[index];
                      var correctAnswer = question.correctAnswer;
                      var backgroundColor = answer == correctAnswer
                          ? Colors.blue
                          : Colors.red;
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuestionNumbers.unique(index + 1, backgroundColor),
                            SizedBox(width: 30),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Question(question.text),
                                  SizedBox(height: 5),
                                  Text(
                                    answer,
                                    style: GoogleFonts.lato(
                                      color: const Color.fromARGB(
                                        255,
                                        255,
                                        0,
                                        255,
                                      ),
                                      fontSize: 15,
                                    ),
                                  ),

                                  SizedBox(height: 5),
                                  Text(
                                    correctAnswer,
                                    style: GoogleFonts.lato(
                                      color: Colors.blue,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
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
