import 'package:flutter/material.dart';
import './exerciseSelections.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  // method to return state to stateful widget
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  //function that returns a widget to be drawn
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Xihao God Life",
      home: Scaffold(
        body: const Center(
          child: ExerciseSelections(),
        ),
      ),
    );
  }
}
