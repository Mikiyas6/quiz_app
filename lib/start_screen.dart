import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(92, 1, 158, 1)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/quiz-logo.png", width: 250),
            SizedBox(height: 70),
            Text(
              "Learn Flutter the fun way!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 50),
            TextButton(
              onPressed: () {},
              child: Text("Start Quiz", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
