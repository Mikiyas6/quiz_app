import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String? activeScreen;
  HashMap<num, String> answeredQuestions = HashMap();
  var isResultButtonClicked = false;

  @override
  void initState() {
    activeScreen = "start-screen";
    super.initState();
  }

  void resetQuiz() {
    setState(() {
      answeredQuestions = HashMap();
      activeScreen = 'start-screen';
      isResultButtonClicked = false;
    });
  }

  bool getResultButtonClicked() {
    return isResultButtonClicked;
  }

  void resultButtonClicked() {
    setState(() {
      isResultButtonClicked = true;
    });
  }

  void switchScreen() {
    setState(() {
      activeScreen = "question-screen";
    });
  }

  void setAnsweredQuestions(index, selectedAnswer) {
    setState(() {
      answeredQuestions[index] = selectedAnswer;
    });
  }

  HashMap<num, String> getAnsweredQuestions() {
    return answeredQuestions;
  }

  List<num> getYetToBeAnswered() {
    final answeredIndices = answeredQuestions.keys.toSet();
    final List<num> result = [];
    for (var i = 0; i < questions.length; i++) {
      if (!answeredIndices.contains(i)) {
        result.add(i);
      }
    }
    result.sort();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidget = activeScreen == "start-screen"
        ? StartScreen(switchScreen)
        : QuestionsScreen(
            setAnsweredQuestions,
            getAnsweredQuestions,
            getYetToBeAnswered,
            resultButtonClicked,
            getResultButtonClicked,
            resetQuiz,
          );
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
