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
    this.getYetToBeAnswered,
    this.resultButtonClicked,
    this.getResultButtonClicked,
    this.resetQuiz, {
    super.key,
  });
  final Function setAnsweredQuestions;
  final Function getAnsweredQuestions;
  final Function getYetToBeAnswered;
  final Function resultButtonClicked;
  final Function getResultButtonClicked;
  final Function resetQuiz;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex;
  var totalPageNumber;

  @override
  void initState() {
    currentQuestionIndex = 0;
    totalPageNumber = questions.length;
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

  @override
  Widget build(BuildContext context) {
    final answeredQuestions = widget.getAnsweredQuestions();
    final isResultButtonClicked = widget.getResultButtonClicked();
    if (currentQuestionIndex == totalPageNumber - 1 &&
        answeredQuestions.length == totalPageNumber) {
      return ResultScreen(
        answeredQuestions,
        totalNumberOfQuestions: totalPageNumber,
        resetQuiz: widget.resetQuiz,
      );
    }
    //Check if reached end of questions
    if (currentQuestionIndex == totalPageNumber) {
      // Get answered questions and check if all answered

      if (answeredQuestions.length == totalPageNumber) {
        return ResultScreen(
          answeredQuestions,
          totalNumberOfQuestions: totalPageNumber,
          resetQuiz: widget.resetQuiz,
        ); // All answered → show results
      }
      // If not all answered, show warning and jump to unanswered
      else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.resultButtonClicked();
        });
        setState(() {
          currentQuestionIndex = widget.getYetToBeAnswered()[0];
        });
      }
    }
    final question = questions[currentQuestionIndex];
    final currentPageNumber = currentQuestionIndex + 1;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QuestionNumbers.normal(currentPageNumber),
                SizedBox(width: 20),
                Expanded(child: Question(question.text)),
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
              ResultButton(widget.resultButtonClicked),
            SizedBox(height: 20),
            Footer(
              currentPageNumber,
              totalPageNumber,
              toPreviousQuestion,
              toNextQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
