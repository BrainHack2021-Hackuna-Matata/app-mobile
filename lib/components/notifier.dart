import 'package:flutter/cupertino.dart';

class NavigationNotifier extends ChangeNotifier {
  int currentTabIndex = 0;

  void setIndex(int newIndex) {
    currentTabIndex = newIndex;
    notifyListeners();
  }
}
