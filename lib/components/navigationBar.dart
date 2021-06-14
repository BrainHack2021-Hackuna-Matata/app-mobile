import 'package:flutter/material.dart';

import '../constants/screens.dart';

class MyAppBar extends StatefulWidget {
  final Map<int, String> screens = ScreenRoutes.getRouteMap();

  static MyAppBar get() {
    return new MyAppBar();
  }

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  int _selectedIndex = 0;
  // bool _hasChanged = false;

  void _onItemTapped(int index) {
    setState(() {
      // _hasChanged = _selectedIndex == index ? false : true;
      _selectedIndex = index;
    });

    // if (_hasChanged && _selectedIndex >= 0 && _selectedIndex < widget.screens.length && widget.screens[_selectedIndex] != null) {
      Navigator.pushNamed(context, widget.screens[_selectedIndex]!);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Meetup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store_outlined),
            label: 'Purchase',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercise',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
