import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';

class Choice extends StatelessWidget {
  const Choice(this.answer, this.chooseAnswer, {super.key});
  final String answer;
  final Function chooseAnswer;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnswerButton(answerText: answer, onTap: () => chooseAnswer(answer)),
        ],
      ),
    );
  }
}
