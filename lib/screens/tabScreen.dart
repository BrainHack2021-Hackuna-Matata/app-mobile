import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/navigationBar.dart';
import './meetupScreen/meetupListScreen.dart';
import './exerciseScreen/exerciseSelectionsScreen.dart';
import '../components/notifier.dart';
import './purchaseScreen/purchaseSplash.dart';
import './purchaseScreen/mapScreen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabscreen';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _pages = [];
  @override
  void initState() {
    _pages = [
      MeetupListScreen(),
      PurchaseSplash(),
      ExerciseSelectionsScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationNotifier>(
      builder: (context, cart, child) {
        return Consumer<UserNotifier>(
          builder: (ctx, user, chld) {
            return user.currentUser.usertype
                ? Scaffold(
                    body: MapScreen(),
                  )
                : Scaffold(
                    bottomNavigationBar: MyAppBar(),
                    body: _pages[cart.currentTabIndex],
                  );
          },
        );
      },
    );
  }
}
