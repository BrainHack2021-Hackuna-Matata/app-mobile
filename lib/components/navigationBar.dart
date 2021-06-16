import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifier.dart';

class MyAppBar extends StatefulWidget {
  static MyAppBar get() {
    return new MyAppBar();
  }

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  void _onItemTapped(NavigationNotifier cart, int index) {
    cart.setIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationNotifier>(
      builder: (context, cart, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Meetup',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store_outlined),
              label: 'Groupbuy',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Workout',
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
