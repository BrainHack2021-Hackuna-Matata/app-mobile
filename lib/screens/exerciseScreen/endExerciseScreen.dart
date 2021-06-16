import 'package:flutter/material.dart';

import '../tabScreen.dart';

class EndExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabScreen(),
                    ),
                    (route) => false),
                child: Text(
                  'Back to home',
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
