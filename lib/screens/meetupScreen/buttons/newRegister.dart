import 'package:eldertly_app/screens/meetupScreen/buttons/customButton.dart';
import 'package:flutter/material.dart';

class NewRegister extends StatelessWidget {
  final String userName;
  final int numComing;
  final int capacity;
  final List<dynamic> attendees;

  void registerMeetupHandler() {
    // Delete entire entry of meetup
    print("TEST");
  }

  NewRegister({
    required this.userName,
    required this.numComing,
    required this.capacity,
    required this.attendees,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // check if meet up reaches capacity
      child: numComing == capacity
          ? Column(
              children: <Widget>[
                MeetupButton(
                  "Register",
                  () => null,
                  Colors.grey,
                ),
                Text(
                  capacity == 1
                      ? "Loading, please wait!"
                      : "Meetup is full\nSelect another meetup.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            )
          : MeetupButton(
              "Register",
              () => registerMeetupHandler,
            ),
    );
  }
}
