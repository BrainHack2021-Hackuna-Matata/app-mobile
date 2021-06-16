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
  bool _pop = false;
  var _exIndex = 0;
  final _exMap = {
    "arm": [
      {
        "file": "assets/exercisegifs/arms 1.gif",
        "name": "Wall Pushups",
      },
      {
        "file": "assets/exercisegifs/arms 2.gif",
        "name": "Shoulder Stretch",
      },
      {
        "file": "assets/exercisegifs/arms 3.gif",
        "name": "Arm Stretch",
      },
      {
        "file": "assets/exercisegifs/arms 4.gif",
        "name": "Shoulder Squeeze",
      },
    ],
    "leg": [
      {
        "file": "assets/exercisegifs/legs 1.gif",
        "name": "Knee Lifts",
      },
      {
        "file": "assets/exercisegifs/legs 2.gif",
        "name": "Heel Raises",
      },
      {
        "file": "assets/exercisegifs/legs 3.gif",
        "name": "Ankle Rotations",
      },
      {
        "file": "assets/exercisegifs/legs 4.gif",
        "name": "Single Leg Balance",
      },
    ],
    "hip": [
      {
        "file": "assets/exercisegifs/hips 1.gif",
        "name": "Abdominal Contractions",
      },
      {
        "file": "assets/exercisegifs/hips 2.gif",
        "name": "Pelvic Tilts",
      },
      {
        "file": "assets/exercisegifs/hips 3.gif",
        "name": "Side Stretch",
      },
      {
        "file": "assets/exercisegifs/hips 4.gif",
        "name": "Oblique Stretch",
      },
    ],
  };

  void confirmpop(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Confirm Quit Workout?',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                content: const Text(
                  'Are you sure you want to quit?',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _pop = false;
                      });
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ]));
  }

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

    return WillPopScope(
      onWillPop: () async {
        confirmpop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Workout"),
        ),
        // show exercise and timer if within index
        body: _exIndex < widget.exList.length
            ? Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                //scaffold used to get the basic app styling
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child:
                          // Name of exercise
                          Text(
                        _exMap[_exType]?[_exNum]["name"] as String,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Play gif
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Image.asset(
                        _exMap[_exType]?[_exNum]["file"] as String,
                        width: MediaQuery.of(context).size.width * .9,
                        height: MediaQuery.of(context).size.height * .5,
                      ),
                    ),

                    // play/pause button
                    TimerButton(_nextEx, _controller),
                  ],
                ),
              )
            : EndExerciseScreen(),
      ),
    );
  }
}
