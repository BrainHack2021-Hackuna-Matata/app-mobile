import 'package:eldertly_app/screens/meetupScreen/meetupCreatorForm.dart';
import 'package:flutter/material.dart';

class AddMeetupScreen extends StatefulWidget {
  @override
  State<AddMeetupScreen> createState() => _AddMeetupScreenState();
}

class _AddMeetupScreenState extends State<AddMeetupScreen> {
  void _submitFormHandler(Map<String, dynamic> form) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
    print(form);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New meetup"),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: MeetupCreatorForm(_submitFormHandler),
      ),
    );
  }
}
