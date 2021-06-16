import 'package:flutter/material.dart';
import './customButton.dart';

class Registered extends StatelessWidget {
  final int id;
  final String userName;
  final int owner;
  final int userID;
  final int numComing;
  final List<dynamic> attendees;
  final Function deregisterMeetupHandler;
  final Function deleteMeetupHandler;
  final String hostname;
  Registered({
    required this.id,
    required this.userName,
    required this.userID,
    required this.owner,
    required this.numComing,
    required this.attendees,
    required this.deregisterMeetupHandler,
    required this.deleteMeetupHandler,
    required this.hostname,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // if user is the only guy there
          (numComing == 1 || userID == owner)
              ? MeetupButton(
                  "Delete",
                  () => deleteMeetupHandler(context),
                  Colors.red,
                )
              : MeetupButton(
                  "Cancel",
                  () => deregisterMeetupHandler(context),
                  Colors.red,
                ),
        ],
      ),
    );
  }
}

// need to have cancel/delete button
