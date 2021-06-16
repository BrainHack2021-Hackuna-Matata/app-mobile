import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class NavigationNotifier extends ChangeNotifier {
  int currentTabIndex = 0;

  void setIndex(int newIndex) {
    currentTabIndex = newIndex;
    notifyListeners();
  }
}

class UserNotifier extends ChangeNotifier {
  User currentUser = User(
    id: -1,
    name: '.',
    mobile: '91234567',
    password: '.',
    usertype: false,
    block: '.',
    postal: '.',
    unit: '.',
    lat: -1,
    long: -1,
    exp: -1,
  );

  void setUser(User user) {
    currentUser = user;
    notifyListeners();
  }
}

