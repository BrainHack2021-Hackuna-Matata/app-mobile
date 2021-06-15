import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/navigationBar.dart';
import './meetupScreen/meetupListScreen.dart';
import './exerciseScreen/exerciseSelectionsScreen.dart';
import './homeScreen/homeScreen.dart';
import '../components/notifier.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _pages = [];
  @override
  void initState() {
    _pages = [
      HomeScreen(),
      MeetupListScreen(),
      HomeScreen(),
      ExerciseSelectionsScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationNotifier>(
      builder: (context, cart, child) {
        return Scaffold(
          bottomNavigationBar: MyAppBar(),
          body: _pages[cart.currentTabIndex],
        );
      },
    );
  }
}
