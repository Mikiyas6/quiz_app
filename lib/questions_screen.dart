import 'package:flutter/material.dart';
import 'package:quiz_app/choice.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/footer.dart';

import 'package:quiz_app/question.dart';
import 'package:quiz_app/questionNumbers.dart';
import 'package:quiz_app/result-button.dart';
import 'package:quiz_app/result_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
    this.setAnsweredQuestions,
    this.getAnsweredQuestions,
    this.getYetToBeAnswered, {
    super.key,
  });
  final Function setAnsweredQuestions;
  final Function getAnsweredQuestions;
  final Function getYetToBeAnswered;
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

  void toPreviousQuestion() {
    setState(() {
      currentQuestionIndex -= 1;
    });
  }

  void chooseAnswer(String answer) {
    setState(() {
      widget.setAnsweredQuestions(currentQuestionIndex, answer);
      currentQuestionIndex += 1;
    });
  }

  void resultButtonClicked() {
    setState(() {
      isResultButtonClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final answeredQuestions = widget.getAnsweredQuestions();
    print(answeredQuestions.length);
    if (currentQuestionIndex == totalPageNumber - 1 &&
        answeredQuestions.length == totalPageNumber) {
      return ResultScreen();
    }
    //Check if reached end of questions
    if (currentQuestionIndex == totalPageNumber) {
      // Get answered questions and check if all answered

      if (answeredQuestions.length == totalPageNumber) {
        return ResultScreen(); // All answered → show results
      }
      // If not all answered, show warning and jump to unanswered
      else {
        setState(() {
          resultButtonClicked();
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
            QuestionNumbers(currentPageNumber),
            SizedBox(width: 10),
            Question(question.text),
          ],
        ),

        SizedBox(height: 15),
        ...question.getShuffledAnswers().map((answer) {
          return Choice(answer, chooseAnswer);
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
          ResultButton(resultButtonClicked),
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
