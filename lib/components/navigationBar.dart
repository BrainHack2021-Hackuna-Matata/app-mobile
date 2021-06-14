import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/screens.dart';
import 'notifier.dart';

class MyAppBar extends StatefulWidget {
  final Map<int, String> screens = ScreenRoutes.getRouteMap();

  static MyAppBar get() {
    return new MyAppBar();
  }

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  void _onItemTapped(NavigationNotifier cart, int index) {
    cart.setIndex(index);
    Navigator.pushNamed(context, widget.screens[index]!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationNotifier>(
        builder: (context, cart, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
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
            currentIndex: cart.currentTabIndex,
            selectedItemColor: Colors.amber[800],
            onTap: (index) => _onItemTapped(cart, index),
          );
        },
    );
  }
}
