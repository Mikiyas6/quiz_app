import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/footer.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/result_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
    this.updateHashmap,
    this.getHashmap,
    this.setAnsweredQuestions,
    this.getAnsweredQuestions,
    this.getYetToBeAnswered,
    this.removeFromYetToBeAnswered, {
    super.key,
  });
  final Function updateHashmap;
  final Function getHashmap;
  final Function setAnsweredQuestions;
  final Function getAnsweredQuestions;
  final Function getYetToBeAnswered;
  final Function removeFromYetToBeAnswered;
  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex;
  var totalPageNumber;
  var isResultButtonClicked;

  @override
  void initState() {
    currentQuestionIndex = 0;
    totalPageNumber = questions.length;
    isResultButtonClicked = false;
    super.initState();
  }

  void toNextQuestion() {
    setState(() {
      currentQuestionIndex += 1;
    });
  }

  void chooseAnswer(answer) {
    setState(() {
      widget.updateHashmap(currentQuestionIndex);
      widget.setAnsweredQuestions(currentQuestionIndex, answer);
      widget.removeFromYetToBeAnswered(currentQuestionIndex);
      currentQuestionIndex += 1;
    });
  }

  void toPreviousQuestion() {
    setState(() {
      currentQuestionIndex -= 1;
    });
  }

  void resultButtonClicked() {
    setState(() {
      isResultButtonClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex == totalPageNumber) {
      // final hashmap = widget.getHashmap();
      final answeredQuestions = widget.getAnsweredQuestions();
      if (answeredQuestions.length == totalPageNumber) {
        return ResultScreen();
      } else if (answeredQuestions.length != totalPageNumber &&
              isResultButtonClicked ||
          currentQuestionIndex == totalPageNumber) {
        setState(() {
          currentQuestionIndex = widget.getYetToBeAnswered()[0];
        });
      }
    }
    final question = questions[currentQuestionIndex];
    final currentPageNumber = currentQuestionIndex + 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(128, 255, 255, 255),
                shape: BoxShape.circle,
              ),
              child: Text(
                "$currentPageNumber",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 10),
            Text(
              question.text,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),

        SizedBox(height: 15),
        ...question.getShuffledAnswers().map((answer) {
          return Container(
            margin: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnswerButton(
                  answerText: answer,
                  onTap: () => chooseAnswer(answer),
                ),
              ],
            ),
          );
        }),
        SizedBox(height: 20),
        if (isResultButtonClicked &&
            widget.getYetToBeAnswered().contains(currentQuestionIndex))
          Text(
            "You didn't answer this question",
            style: TextStyle(color: Colors.red),
          ),
        SizedBox(height: 20),
        if (currentPageNumber == totalPageNumber)
          OutlinedButton.icon(
            label: Text("See Result", style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.arrow_right, color: Colors.white),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
              ),
            ),
            onPressed: resultButtonClicked,
          ),
        SizedBox(height: 20),
        Footer(
          currentPageNumber,
          totalPageNumber,
          toPreviousQuestion,
          toNextQuestion,
        ),
      ],
    );
  }
}
