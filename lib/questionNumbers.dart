import 'package:flutter/material.dart';

class QuestionNumbers extends StatelessWidget {
  const QuestionNumbers(this.currentPageNumber, {super.key});
  final num currentPageNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
