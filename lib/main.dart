import 'package:flutter/material.dart';
import './workout.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  // method to return state to stateful widget
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List availEx = ["arms", "legs", "hips"];

  @override
  //function that returns a widget to be drawn
  Widget build(BuildContext context) {
    //MaterialApp widget returned
    return MaterialApp(
      //scaffold used to get the basic app styling
      home: Scaffold(
        body: Center(
          child: Workout(availEx),
        ),
      ),
    );
  }
}
