import 'package:flutter/material.dart';
import 'package:custom_timer/custom_timer.dart';

class TimerButton extends StatefulWidget {
  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  Icon fab = Icon(
    Icons.pause,
  );
  bool playing = true;
  final CustomTimerController _controller = new CustomTimerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Timer
          CustomTimer(
            controller: _controller,
            from: Duration(minutes: 1),
            to: Duration(minutes: 0),
            onBuildAction: CustomTimerAction.auto_start,
            builder: (CustomTimerRemainingTime remaining) {
              return Text(
                "${remaining.seconds}s",
                style: TextStyle(fontSize: 40.0),
              );
            },
          ),
          FloatingActionButton(
            child: fab,
            onPressed: () => setState(() {
              if (playing) {
                fab = Icon(
                  Icons.play_arrow,
                );
                playing = false;
                _controller.pause();
              } else {
                fab = Icon(
                  Icons.pause,
                );
                playing = true;
                _controller.start();
              }
            }),
          ),
        ],
      ),
    );
  }
}
