import 'package:flutter/material.dart';

import '../../components/navigationBar.dart';

class MeetupListScreen extends StatefulWidget {
  const MeetupListScreen({Key? key}) : super(key: key);

  @override
  _MeetupListScreenState createState() => _MeetupListScreenState();
}

class _MeetupListScreenState extends State<MeetupListScreen> {
  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Scaffold(
    //     bottomNavigationBar: MyAppBar(),
    //     body: Container(
    //       child: Text("HELLO MOTHERFUCKER", style: TextStyle(color: Colors.red), ),
    //     ),
    //   ),
    // );
    return Scaffold(
      bottomNavigationBar: MyAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "HELLO MOTHERFUCKER",
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
