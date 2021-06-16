import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './addPurchaseScreen.dart';
import './viewActivePurchase.dart';
import '../../api/static.dart';
import '../../components/notifier.dart';

class PurchaseSplash extends StatefulWidget {
  @override
  _PurchaseSplashState createState() => _PurchaseSplashState();
}

class _PurchaseSplashState extends State<PurchaseSplash> {
  String screenToRender = "";
  Map<String, dynamic> firstPost = {};

  @override
  initState() {
    super.initState();
    _getCorrespondingScreen();
  }

  void _getCorrespondingScreen() async {
    final int userId = Provider.of<UserNotifier>(context, listen: false).currentUser.id;
    await http.get(Uri.parse('${Api.CURR_URL}/posts/user/$userId')).then((res) {
      Map<String, dynamic> body = jsonDecode(res.body);
      int length = body['length'];

      setState(() {
        if (length == 0) {
          screenToRender = 'add';
        } else {
          screenToRender = 'active';
          firstPost = body['data'][0];
        }
      });
    }).catchError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred, please try again later")));
    });
  }

  Widget _renderScreen(String screenEnum) {
    switch (screenEnum) {
      case 'add':
        {
          return AddPurchaseScreen(_getCorrespondingScreen);
        }
      case 'active':
        {
          return ViewActivePurchase(
            id: firstPost['id'],
            blkNum: firstPost["location"],
            helpNeeded: firstPost['title'],
            dueDate: firstPost['due'],
            details: firstPost['description'],
            name: firstPost['name'],
            accepted: firstPost['accepted'],
            fulfilled: firstPost['fulfilled'],
            unit: firstPost['unit'],
            refreshSplashScreen: _getCorrespondingScreen,
          );
        }
      default:
        {
          return Scaffold(
            appBar: AppBar(title: Text("Purchase")),
            body: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    _getCorrespondingScreen();
    return Container(child: _renderScreen(screenToRender));
  }
}
