import './purchaseCreatorForm.dart';
import 'package:flutter/material.dart';

class AddPurchaseScreen extends StatefulWidget {
  @override
  State<AddPurchaseScreen> createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  void _submitFormHandler(Map<String, dynamic> form) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
    print(form);
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
