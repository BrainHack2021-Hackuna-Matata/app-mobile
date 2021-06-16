import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../api/static.dart';
import '../../components/notifier.dart';
import './mapScreen.dart';
import './addPurchaseScreen.dart';
import './viewActivePurchase.dart';
import 'dart:convert';

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
    setState((){
      screenToRender = "";
      firstPost = {};
    });
    final int userId = Provider.of<UserNotifier>(context).currentUser.id;
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
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred, please try again later")));
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
          return Container(
            child: Text("Loading"),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    _getCorrespondingScreen();

    return Container(child: _renderScreen(screenToRender));
    // return Scaffold(
    //   body: SafeArea(
    //     minimum: EdgeInsets.symmetric(horizontal: 20),
    //     child: Column(
    //       children: <Widget>[
    //         Spacer(),
    //         Text("What would you like to do today?",
    //             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    //         SizedBox(height: 20),
    //         ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //               primary: Colors.lightBlue,
    //               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //               textStyle:
    //                   TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => AddPurchaseScreen(),
    //               ), //DEBUG
    //             );
    //           },
    //           child: const Text(
    //               "I need help buying things\n我需要帮忙买东西\nSaya memerlukan pertolongan untuk membeli barangn\nபொருட்களை வாங்க எனக்கு உதவி தேவை",
    //               textAlign: TextAlign.right),
    //         ),
    //         SizedBox(height: 20),
    //         ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //               primary: Colors.lightBlue,
    //               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //               textStyle:
    //                   TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               // MaterialPageRoute(builder: (context) => ViewActiveCommit(
    //               //       blkNum: "123A",
    //               //       helpNeeded: "Food Needed",
    //               //       dueDate: "2021-06-16 13:57:23.100" ,
    //               //       name: "Tan Ah Cow",
    //               //       unit: "#02-22",
    //               //       image: "assets/purchase_default/meal_default.jpg" ,
    //               //       details: "rice with lao gan ma",
    //               //       accepted: true,
    //               //       fulfilled: false,
    //               //     )),
    //               MaterialPageRoute(
    //                 builder: (context) => MapScreen(),
    //               ),
    //             );
    //           },
    //           child: const Text(
    //               "I want to help\n我想帮忙\nSaya ingin membantu\nநான் உதவி செய்ய வேண்டும்",
    //               textAlign: TextAlign.right),
    //         ),
    //         SizedBox(height: 100)
    //       ],
    //     ),
    //   ),
    // );
  }
}
