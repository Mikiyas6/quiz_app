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
  HashMap<num, num> hashmap = HashMap();
  HashMap<num, String> answeredQuestions = HashMap();
  List<num> yetToBeAnswered = [];

  @override
  void initState() {
    activeScreen = "start-screen";
    for (var i = 0; i < questions.length; i++) {
      hashmap[i] = 0;
    }
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = "question-screen";
    });
  }

  HashMap<num, num> getHashmap() {
    return hashmap;
  }

  void setAnsweredQuestions(index, selectedAnswer) {
    answeredQuestions[index] = selectedAnswer;
  }

  HashMap<num, String> getAnsweredQuestions() {
    return answeredQuestions;
  }

  void updateHashmap(index) {
    hashmap[index] = (hashmap[index] ?? 0) + 1;
  }

  List<num> getYetToBeAnswered() {
    hashmap.forEach((key, value) {
      if (value == 0) {
        yetToBeAnswered.add(key);
      }
    });
    return yetToBeAnswered;
  }

  void removeFromYetToBeAnswered(index) {
    if (yetToBeAnswered.contains(index)) {
      yetToBeAnswered.removeWhere(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidget = activeScreen == "start-screen"
        ? StartScreen(switchScreen)
        : QuestionsScreen(
            updateHashmap,
            getHashmap,
            setAnsweredQuestions,
            getAnsweredQuestions,
            getYetToBeAnswered,
            removeFromYetToBeAnswered,
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
