import 'package:flutter/material.dart';

class QuestionNumbers extends StatelessWidget {
  const QuestionNumbers(
    this.currentPageNumber,
    this.backgroundColor, {
    super.key,
  });
  const QuestionNumbers.normal(this.currentPageNumber, {super.key})
    : this.backgroundColor = const Color.fromARGB(255, 98, 96, 96);
  final num currentPageNumber;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Text(
        "$currentPageNumber",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
