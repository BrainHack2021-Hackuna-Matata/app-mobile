import './purchaseCreatorForm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/static.dart';

class AddPurchaseScreen extends StatefulWidget {
  @override
  State<AddPurchaseScreen> createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  void _submitFormHandler(Map<String, dynamic> form) async {
    String jsonStringForm = jsonEncode(form);

    await http.post(Uri.parse("${Api.CURR_URL}/posts"), body: jsonStringForm).then((res) {
      print(res.statusCode);
      print(res.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Submitted")));
      Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
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
