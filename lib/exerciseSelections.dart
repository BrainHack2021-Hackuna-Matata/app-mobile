import 'package:flutter/material.dart';

class ExerciseSelections extends StatefulWidget {
  const ExerciseSelections({Key? key}) : super(key: key);

  @override
  State<ExerciseSelections> createState() => _ExerciseSelectionsState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ExerciseSelectionsState extends State<ExerciseSelections> {
  bool _arms = false;
  bool _legs = false;
  bool _hips = false;
  bool _selectedExercises = false;
  var exerciseTimes = ["No Exercises Selected","5 Minutes","10 Minutes","15 Minutes"];
  int selectedCount = 0;

  countSelectedExercises(){
    int count = 0;
    if (_arms == true){
      count += 1;
    }
      if (_legs == true){
      count += 1;
    }
      if (_hips == true){
      count += 1;
    }
    return count;
  }

/// This is the stateful widget that the main application instantiates.

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
    
    Column( //####Row of Columns of Selection buttons + text underneath
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
        child: InkWell(
          onTap: () {
            setState(() {
              _arms = !_arms;
              _selectedExercises = _arms || _legs || _hips;
              selectedCount = countSelectedExercises();
            });
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: _arms
              ? Image.asset('assets/icons/arm.png', gaplessPlayback: true)
              : Image.asset('assets/icons/arm-off.png', gaplessPlayback: true),
            ),),
        ),
        ),
        Material(
        child: InkWell(
          onTap: () {
            setState(() {
              _legs = !_legs;
              _selectedExercises = _arms || _legs || _hips;
              selectedCount = countSelectedExercises();
            });
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: _legs
              ? Image.asset('assets/icons/leg.png', gaplessPlayback: true)
              : Image.asset('assets/icons/leg-off.png', gaplessPlayback: true),
            ),),
        ),
        ),
        Material(
        child: InkWell(
          onTap: () {
            setState(() {
              _hips = !_hips;
              _selectedExercises = _arms || _legs || _hips;
              selectedCount = countSelectedExercises();
            });
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: _hips
              ? Image.asset('assets/icons/hip.png', gaplessPlayback: true)
              : Image.asset('assets/icons/hip-off.png', gaplessPlayback: true),
            ),),
        ),
        ),
      ]
    ),
    Text("Estimated Exercise Time:",
    style: TextStyle(fontSize: 30,  )),
    Text(exerciseTimes[selectedCount],
    style: TextStyle(fontSize: 30)),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold)), 
      onPressed: _selectedExercises
      ? (){}
      : null,
      child: _selectedExercises
      ? const Text('Start Exercise!')
      : const Text('No Exercises Selected')
    ),
    ]
    );

  }
}
