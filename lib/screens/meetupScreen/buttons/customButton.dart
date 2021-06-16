import 'package:flutter/material.dart';

class MeetupButton extends StatelessWidget {
  final String text;
  final Function buttonHandler;
  final Color butColor;

  MeetupButton(this.text, this.buttonHandler, [this.butColor = Colors.amber]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () => buttonHandler(),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 50),
          primary: butColor,
        ),
      ),
    );
  }
}
