import 'package:flutter/material.dart';

import '../components/navigationBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyAppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Text(
          "Home Screen Here",
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
