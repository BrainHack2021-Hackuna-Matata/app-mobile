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
              "Congratulations!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "You have completed your workout!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
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
                    fontSize: 30,
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
