import 'package:flutter/material.dart';

class ResultButton extends StatelessWidget {
  const ResultButton(this.resultButtonClicked, {super.key});
  final Function resultButtonClicked;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      label: Text("See Result", style: TextStyle(color: Colors.white)),
      icon: Icon(Icons.arrow_right, color: Colors.white),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
        ),
      ),
      onPressed: () {
        resultButtonClicked();
      },
    );
  }
}
