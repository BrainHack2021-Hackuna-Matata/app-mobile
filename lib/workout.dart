import 'package:flutter/material.dart';
import './timer.dart';

class Workout extends StatelessWidget {
  final List availEx;

  Workout(this.availEx);

  final gifsmap = {
    "arm": [
      {
        "file": "exercisegifs/arm1.gif",
        "name": "Arm Rotation",
      },
      {
        "file": "exercisegifs/arm2.gif",
        "name": "Arm Flex",
      },
    ],
    "leg": [
      {
        "file": "exercisegifs/leg1.gif",
        "name": "Leg Rotation",
      },
      {
        "file": "exercisegifs/leg2.gif",
        "name": "Leg Flex",
      },
    ],
    "hip": [
      {
        "file": "exercisegifs/hip1.gif",
        "name": "Hip Rotation",
      },
      {
        "file": "exercisegifs/hip2.gif",
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
