import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/footer.dart';
import 'package:quiz_app/models/quiz_question.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});
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

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex == totalPageNumber) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You hit the end. Go back if you want",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 10),
          OutlinedButton.icon(
            label: Text("Go Back", style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.arrow_left, color: Colors.white),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
              ),
            ),
            onPressed: toPreviousQuestion,
          ),
        ],
      );
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
              style: TextStyle(color: Colors.white),
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
                AnswerButton(answerText: answer, onTap: toNextQuestion),
              ],
            ),
          );
        }),
        SizedBox(height: 100),
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
