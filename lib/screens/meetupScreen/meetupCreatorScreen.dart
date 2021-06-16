import 'dart:convert';

import 'package:eldertly_app/api/static.dart';
import 'package:eldertly_app/screens/meetupScreen/meetupCreatorForm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddMeetupScreen extends StatefulWidget {
  @override
  State<AddMeetupScreen> createState() => _AddMeetupScreenState();
}

class _AddMeetupScreenState extends State<AddMeetupScreen> {
  bool _postSuccessful = false;

  void _postData(String jsonStringForm) async {
    await http.post(Uri.parse("${Api.CURR_URL}/meetups"), body: jsonStringForm).then((res) {
      setState(() {
        _postSuccessful = true;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void _submitFormHandler(Map<String, dynamic> form) async {
    _postData(jsonEncode(form));

    if (_postSuccessful) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Submitted")));
      Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred, please try again later")));
    }
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
