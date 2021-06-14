import 'package:flutter/material.dart';

class EndExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "GOOD JOB!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
            ),
          ),
          Text(
            "Exercise Complete!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}
