import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../tabScreen.dart';
import './registerScreen.dart';
import '../../models/user.dart';
import '../../components/notifier.dart';
import '../../api/static.dart';

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
  bool _notext = false;
  // Widget register() {

  // }
  void clickLogin(UserNotifier user) async {
    if (mobileController.text == '' || passwordController.text == '') {
      _notext = true;
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height - 60,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage('assets/icons/icon.png'),
                    height: 50,
                    width: 50),
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
                          ? 'Please Enter Something in both fields...'
                          : _wrongpassword
                              ? 'Wrong Password Entered'
                              : null,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: double.infinity,
                  child: Consumer<UserNotifier>(
                    builder: (context, user, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                        ),
                        child: Text('Continue',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        onPressed: () async => clickLogin(user),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
