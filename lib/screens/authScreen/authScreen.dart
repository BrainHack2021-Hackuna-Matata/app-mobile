import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './registerScreen.dart';
import '../../api/static.dart';
import '../../components/notifier.dart';
import '../../models/user.dart';
import '../tabScreen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class LoginData {
  final String mobile;
  final String password;

  LoginData(this.mobile, this.password);
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _wrongpassword = false;
  bool _wrongformat = false;
  bool _notext = false;

  void clickLogin(UserNotifier user) async {
    if (mobileController.text == '' || passwordController.text == '') {
      _notext = true;
      return;
    } else if (int.tryParse(mobileController.text) == null || mobileController.text.length != 8) {
      _wrongformat = true;
      return;
    }

    await http
        .post(
      Uri.parse('${Api.CURR_URL}/login'),
      body: jsonEncode({
        'mobile': mobileController.text,
        'password': passwordController.text,
      }),
    )
        .then((res) {
      if (res.body == '{"message": "Wrong password."}') {
        setState(() {
          _wrongpassword = true;
        });
      } else if (res.body == '{"message": "Redirect to register page"}') {
        Navigator.of(context).pushNamed(
          RegisterScreen.routeName,
          arguments: LoginData(
            mobileController.text,
            passwordController.text,
          ),
        );
      } else {
        var r = jsonDecode(res.body);
        var newUser = User(
          id: r['id'],
          name: r['name'],
          mobile: r['mobile'],
          password: r['password'],
          postal: r['postal'],
          unit: r['unit'],
          usertype: r['usertype'],
          block: r['block'],
          lat: double.parse(r['lat']),
          long: double.parse(r['long']),
          exp: r['exp'],
        );
        user.setUser(newUser);
        Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height - 60,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/icons/icon.png'), height: 50, width: 50),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: mobileController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile number',
                    errorText: _wrongformat ? 'Please enter a valid SG number' : null,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(),
                    errorText: _notext
                        ? 'Please enter Something in both fields...'
                        : _wrongpassword
                            ? 'Wrong password entered'
                            : null,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                width: double.infinity,
                child: Consumer<UserNotifier>(
                  builder: (context, user, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                      ),
                      child: Text('Continue'),
                      onPressed: () async => clickLogin(user),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
