import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../components/timer.dart';
import './endExerciseScreen.dart';

class ExerciseScreen extends StatefulWidget {
  final exList;
  ExerciseScreen(this.exList);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  var _exIndex = 0;
  final _exMap = {
    "arm": [
      {
        "file": "assets/exercisegifs/arm1.gif",
        "name": "Arm 1",
      },
      {
        "file": "assets/exercisegifs/arm2.gif",
        "name": "Arm 2",
      },
      {
        "file": "assets/exercisegifs/arm3.gif",
        "name": "Arm 3",
      },
      {
        "file": "assets/exercisegifs/arm4.gif",
        "name": "Arm 4",
      },
    ],
    "leg": [
      {
        "file": "assets/exercisegifs/leg1.gif",
        "name": "Leg 1",
      },
      {
        "file": "assets/exercisegifs/leg2.gif",
        "name": "Leg 2",
      },
      {
        "file": "assets/exercisegifs/leg3.gif",
        "name": "Leg 3",
      },
      {
        "file": "assets/exercisegifs/leg4.gif",
        "name": "Leg 4",
      },
    ],
    "hip": [
      {
        "file": "assets/exercisegifs/hip1.gif",
        "name": "Hip 1",
      },
      {
        "file": "assets/exercisegifs/hip2.gif",
        "name": "Hip 2",
      },
      {
        "file": "assets/exercisegifs/hip3.gif",
        "name": "Hip 3",
      },
      {
        "file": "assets/exercisegifs/hip4.gif",
        "name": "hip 4",
      },
    ],
  };

  final CountdownController _controller = new CountdownController();
  // Type of exercise e.g.: arms
  String _exType = "";
  // exercise number e.g.: arm 1
  int _exNum = 0;

  void _nextEx(controller) {
    setState(() {
      _exIndex++;
      _exIndex < widget.exList.length ? _controller.restart() : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update only if not out of index
    if (_exIndex < widget.exList.length) {
      _exType = widget.exList[_exIndex][0];
      _exNum = widget.exList[_exIndex][1];
    }

    return Scaffold(
      // show exercise and timer if within index
      body: _exIndex < widget.exList.length
          ? Container(
              width: double.infinity,
              height: double.infinity,
              //scaffold used to get the basic app styling
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name of exercise
                  Text(
                    _exMap[_exType]?[_exNum]["name"] as String,
                    style: TextStyle(fontSize: 32),
                  ),

                  // Create gap between name and gif
                  SizedBox(height: 10),

                  // Play gif
                  Image.asset(
                    _exMap[_exType]?[_exNum]["file"] as String,
                    width: MediaQuery.of(context).size.width * .9,
                    height: MediaQuery.of(context).size.height * .5,
                  ),

                  // play/pause button
                  TimerButton(_nextEx, _controller),
                ],
              ),
            )
          : EndExerciseScreen(),
    );
  }
}
