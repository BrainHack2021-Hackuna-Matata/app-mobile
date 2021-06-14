import 'package:flutter/material.dart';

import '../components/navigationBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("ElderlyApp"),
      ),
      bottomNavigationBar: MyAppBar.get(),
    );
  }
}
