import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TimerButton extends StatefulWidget {
  final Function nextEx;
  final CountdownController controller;

  TimerButton(this.nextEx, this.controller);

  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  Icon fab = Icon(
    Icons.pause,
  );
  bool playing = true;
  bool start = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Timer
          Countdown(
            controller: widget.controller,
            seconds: 3,
            interval: Duration(milliseconds: 100),
            build: (BuildContext context, double time) {
              if (!start) {
                widget.controller.resume();
                start = true;
              }
              return Text(
                "${time}s",
                style: TextStyle(fontSize: 40.0),
              );
            },
            onFinished: () => widget.nextEx(widget.controller),
          ),
          FloatingActionButton(
            child: fab,
            onPressed: () => setState(() {
              if (playing) {
                fab = Icon(
                  Icons.play_arrow,
                );
                playing = false;
                widget.controller.pause();
              } else {
                fab = Icon(
                  Icons.pause,
                );
                playing = true;
                widget.controller.resume();
              }
            }),
          ),
        ],
      ),
    );
  }
}
