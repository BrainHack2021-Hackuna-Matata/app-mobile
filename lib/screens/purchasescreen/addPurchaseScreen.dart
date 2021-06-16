import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './purchaseCreatorForm.dart';
import '../../api/static.dart';

class AddPurchaseScreen extends StatefulWidget {
  Function _refreshSplashScreen;

  AddPurchaseScreen(this._refreshSplashScreen);

  @override
  State<AddPurchaseScreen> createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  void _submitFormHandler(Map<String, dynamic> form) async {
    String jsonStringForm = jsonEncode(form);

    await http.post(Uri.parse("${Api.CURR_URL}/posts"), body: jsonStringForm).then((res) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Submitted")));
      widget._refreshSplashScreen();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred, please try again later")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Request"),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: PurchaseCreatorForm(_submitFormHandler),
      ),
    );
  }
}
