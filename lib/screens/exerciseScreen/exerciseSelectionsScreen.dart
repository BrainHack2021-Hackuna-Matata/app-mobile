import 'package:flutter/material.dart';

import './workoutScreen.dart';

class ExerciseSelectionsScreen extends StatefulWidget {
  const ExerciseSelectionsScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseSelectionsScreen> createState() =>
      _ExerciseSelectionsScreenState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ExerciseSelectionsScreenState extends State<ExerciseSelectionsScreen> {
  bool _arms = false;
  bool _legs = false;
  bool _hips = false;
  late bool _ExercisesSelected;

  var exerciseTimes = [
    "No Exercises Selected",
    "5 Minutes",
    "10 Minutes",
    "15 Minutes"
  ];
  int selectedCount = 0;

  countSelectedExercises() {
    int count = 0;
    if (_arms == true) {
      count += 1;
    }
    if (_legs == true) {
      count += 1;
    }
    if (_hips == true) {
      count += 1;
    }
    return count;
  }

  //OnPressed Function to navigate
  void selectExerciseHandler(arms, legs, hips) {
    List tempEx = [];
    List compileEx = [];
    int numType = 0;
    List list = List.generate(4, (i) => i);
    if (arms == true) {
      list.shuffle();
      for (int i = 0; i < 3; i++) {
        tempEx.add(["arm", list[i]]);
      }
      numType++;
    }
    if (hips == true) {
      list.shuffle();
      for (int i = 0; i < 3; i++) {
        tempEx.add(["hip", list[i]]);
      }
      numType++;
    }
    if (legs == true) {
      list.shuffle();
      for (int i = 0; i < 3; i++) {
        tempEx.add(["leg", list[i]]);
      }
      numType++;
    }

    for (int i = 0; i < (tempEx.length / numType).floor(); i++) {
      for (int j = i; j < tempEx.length; j += 3) {
        compileEx.add(tempEx[j]);
      }
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ExerciseScreen(compileEx)));
  }

  /// This is the stateful widget that the main application instantiates.

  @override
  Widget build(BuildContext context) {
    _ExercisesSelected = _arms || _legs || _hips;

    selectedCount = countSelectedExercises();

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Workout"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ExerciseOption(
              "arm",
              _arms,
              () {
                setState(() {
                  _arms = _arms ? false : true;
                });
              },
            ),
            ExerciseOption(
              "hip",
              _hips,
              () {
                setState(() {
                  _hips = _hips ? false : true;
                });
              },
            ),
            ExerciseOption(
              "leg",
              _legs,
              () {
                setState(() {
                  _legs = _legs ? false : true;
                });
              },
            ),

            //print time taken for exercises
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: _ExercisesSelected
                  ? Text(
                      'Estimated Exercise Time:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    )
                  : null,
            ),
            Text(
              exerciseTimes[selectedCount],
              style: TextStyle(
                fontSize: 25,
              ),
            ),

            //start button
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: _ExercisesSelected
                    ? () => selectExerciseHandler(_arms, _legs, _hips)
                    : null,
                child: Text('START'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 80),
                  textStyle: TextStyle(
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

class ExerciseOption extends StatelessWidget {
  final String _imageName;
  final bool _isActive;
  final VoidCallback onPress;

  ExerciseOption(this._imageName, this._isActive, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: _isActive
          ? null
          : BoxDecoration(
              color: Colors.grey,
              backgroundBlendMode: BlendMode.saturation,
            ),
      child: InkWell(
        onTap: onPress,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
                "assets/icons/${_isActive ? _imageName : '${_imageName}-off'}.png",
                gaplessPlayback: true),
          ),
        ),
      ),
    );
  }
}
