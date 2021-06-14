import 'package:flutter/material.dart';

import './workoutScreen.dart';
import '../../components/navigationBar.dart';

class ExerciseSelectionsScreen extends StatefulWidget {
  const ExerciseSelectionsScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseSelectionsScreen> createState() => _ExerciseSelectionsScreenState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ExerciseSelectionsScreenState extends State<ExerciseSelectionsScreen> {
  bool _arms = false;
  bool _legs = false;
  bool _hips = false;
  bool _selectedExercises = false;
  var exerciseTimes = ["No Exercises Selected", "5 Minutes", "10 Minutes", "15 Minutes"];
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

    print(compileEx);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExerciseScreen(compileEx)));
  }

  /// This is the stateful widget that the main application instantiates.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyAppBar(),
      body: Column(
        children: <Widget>[
          ExerciseOption("arm", _arms, () {
            setState(() {
              _arms = _arms ? false : true;
            });
          }),
          ExerciseOption("hip", _hips, () {
            setState(() {
              _hips = _hips ? false : true;
            });
          }),
          ExerciseOption("leg", _legs, () {
            setState(() {
              _legs = _legs ? false : true;
            });
          }),
        ],
      ),
      // body: SafeArea (
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Column(
      //           //####Row of Columns of Selection buttons + text underneath
      //           // mainAxisSize: MainAxisSize.min,
      //           children: <Widget>[
      //             Material(
      //               child: InkWell(
      //                 onTap: () {
      //                   setState(() {
      //                     _arms = !_arms;
      //                     _selectedExercises = _arms || _legs || _hips;
      //                     selectedCount = countSelectedExercises();
      //                   });
      //                 },
      //                 child: Container(
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(20.0),
      //                     child: _arms ? Image.asset('assets/icons/arm.png', gaplessPlayback: true) : Image.asset('assets/icons/arm-off.png', gaplessPlayback: true),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             //space between buttons
      //             SizedBox(height: 20),
      //
      //             Material(
      //               child: InkWell(
      //                 onTap: () {
      //                   setState(() {
      //                     _hips = !_hips;
      //                     _selectedExercises = _arms || _legs || _hips;
      //                     selectedCount = countSelectedExercises();
      //                   });
      //                 },
      //                 child: Container(
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(20.0),
      //                     child: _hips ? Image.asset('assets/icons/hip.png', gaplessPlayback: true) : Image.asset('assets/icons/hip-off.png', gaplessPlayback: true),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             //space between buttons
      //             SizedBox(height: 20),
      //             Material(
      //               child: InkWell(
      //                 onTap: () {
      //                   setState(() {
      //                     _legs = !_legs;
      //                     _selectedExercises = _arms || _legs || _hips;
      //                     selectedCount = countSelectedExercises();
      //                   });
      //                 },
      //                 child: Container(
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(20.0),
      //                     child: _legs ? Image.asset('assets/icons/leg.png', gaplessPlayback: true) : Image.asset('assets/icons/leg-off.png', gaplessPlayback: true),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ]),
      //       SizedBox(height: 20),
      //       Text("Estimated Exercise Time:",
      //           style: TextStyle(
      //             fontSize: 25,
      //           )),
      //       Text(exerciseTimes[selectedCount], style: TextStyle(fontSize: 25)),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //               primary: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      //           onPressed: _selectedExercises
      //               ? () => selectExerciseHandler(_arms, _legs, _hips) // What happens after start exercise
      //               : null,
      //           child: _selectedExercises ? const Text('Start Exercise!') : const Text('No Exercises Selected')),
      //     ],
      //   ),
      // ),
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
      child: IconButton(
        icon: Image.asset("assets/icons/${_isActive ? _imageName : '${_imageName}-off'}.png"),
        iconSize: 100,
        onPressed: onPress,
      ),
    );
  }
}
