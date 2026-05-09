import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer(
    this.currentPageNumber,
    this.totalPageNumber,
    this.toPreviousQuestion,
    this.toNextQuestion, {
    super.key,
  });

  final num currentPageNumber;
  final num totalPageNumber;
  final Function toPreviousQuestion;
  final Function toNextQuestion;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (currentPageNumber != 1)
          IconButton.filled(
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(33, 232, 231, 231),
              iconSize: 20,
            ),
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              toPreviousQuestion();
            },
          ),
        SizedBox(width: 15),
        Text(
          "$currentPageNumber",
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        SizedBox(width: 15),
        if (currentPageNumber < totalPageNumber)
          IconButton.filled(
            style: IconButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(33, 232, 231, 231),

              iconSize: 20,
            ),
            onPressed: () {
              toNextQuestion();
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
      ],
    );
  }
}
