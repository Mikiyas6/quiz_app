import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.switchScreen, {super.key});

  final Function switchScreen;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/quiz-logo.png",
          width: 300,
          color: Color.fromARGB(150, 255, 255, 255),
        ),
        SizedBox(height: 70),
        Text(
          "Learn Flutter the fun way!",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 50),
        OutlinedButton.icon(
          label: Text("Start Quiz", style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.arrow_right_alt, color: Colors.white),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
            ),
          ),
          onPressed: () {
            switchScreen();
          },
        ),
      ],
    );
  }
}
