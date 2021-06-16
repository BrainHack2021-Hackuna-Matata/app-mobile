import 'package:flutter/material.dart';
import './customButton.dart';

class Registered extends StatelessWidget {
  final String userName;
  final int numComing;
  final List<dynamic> attendees;

  Registered({
    required this.userName,
    required this.numComing,
    required this.attendees,
  });

  void deleteMeetupHandler() {
    // Delete entire entry of meetup
    print("TEST");
  }

  void cancelMeetupHandler() {
    // remove user from attendees list
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MeetupButton(
            "Registered",
            () => null,
            Colors.green,
          ),

          // if user is the only guy there
          numComing == 1
              ? MeetupButton(
                  "Delete",
                  deleteMeetupHandler,
                  Colors.red,
                )
              : MeetupButton(
                  "Cancel",
                  cancelMeetupHandler,
                  Colors.red,
                ),
        ],
      ),
    );
  }
}

// need to have cancel/delete button
