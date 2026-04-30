import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String? activeScreen;

  @override
  void initState() {
    activeScreen = "start-screen";
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = "question-screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidget = activeScreen == "start-screen"
        ? StartScreen(switchScreen)
        : QuestionsScreen();
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(92, 1, 158, 1)),
          child: Center(child: screenWidget),
        ),
      ),
    );
  }
}
