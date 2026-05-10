import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Question extends StatelessWidget {
  const Question(this.question, {super.key});
  final String question;
  @override
  Widget build(BuildContext context) {
    return Text(
      question,
      style: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );
  }
}
