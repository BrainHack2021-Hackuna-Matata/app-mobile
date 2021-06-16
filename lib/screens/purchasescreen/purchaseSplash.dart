import 'package:flutter/material.dart';
import './mapScreen.dart';
import './addPurchaseScreen.dart';
import './purchaseCreatorForm.dart';
import './checkActiveListing.dart';
import './pendingPurchase.dart';

class PurchaseSplash extends StatefulWidget {
  @override
  State<PurchaseSplash> createState() => PurchaseSplashState();
}

class PurchaseSplashState extends State<PurchaseSplash> {
  //void initState() {
  //}
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
      Spacer(),
      Text("What would you like to do today?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      SizedBox(height: 20),
      ElevatedButton(
            style: ElevatedButton.styleFrom(
      primary: Colors.lightBlue, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddPurchaseScreen()),
  );
},
            child: const Text("I need help buying things\n我需要帮忙买东西\nSaya memerlukan pertolongan untuk membeli barangn\nபொருட்களை வாங்க எனக்கு உதவி தேவை", textAlign : TextAlign.right),
      ),
      SizedBox(height: 20),

      ElevatedButton(
            style: ElevatedButton.styleFrom(
      primary: Colors.lightBlue, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => MapScreen()),
  );
},
            child: const Text("I want to help\n我想帮忙\nSaya ingin membantu\nநான் உதவி செய்ய வேண்டும்", textAlign : TextAlign.right),
      ),
      SizedBox(height: 100)
],)
    );
  }
}