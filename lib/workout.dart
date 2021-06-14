import 'package:flutter/material.dart';
import './timer.dart';

class Workout extends StatelessWidget {
  final gifsmap = {
    "arm": [
      {
        "file": "assets/exercisegifs/arm1.gif",
        "name": "Arm Rotation",
      },
      {
        "file": "assets/exercisegifs/arm2.gif",
        "name": "Arm Flex",
      },
    ],
    "leg": [
      {
        "file": "assets/exercisegifs/leg1.gif",
        "name": "Leg Rotation",
      },
      {
        "file": "assets/exercisegifs/leg2.gif",
        "name": "Leg Flex",
      },
    ],
    "hip": [
      {
        "file": "assets/exercisegifs/hip1.gif",
        "name": "Hip Rotation",
      },
      {
        "file": "assets/exercisegifs/hip2.gif",
        "name": "Hip Flex",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    //MaterialApp widget returned
    return Container(
      width: double.infinity,
      height: double.infinity,
      //scaffold used to get the basic app styling
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Name of exercist
          Text(
            "Arm Rotations",
            style: TextStyle(fontSize: 32),
          ),

          // Create gap between name and gif
          SizedBox(height: 10),

          // Play gif
          Image.asset(
            "exercisegifs/arm1.gif",
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .5,
          ),

          // play/pause button
          TimerButton(),
        ],
      ),
    );
  }
}
