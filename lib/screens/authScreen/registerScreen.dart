import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../tabScreen.dart';
import './authScreen.dart';
import '../../models/user.dart';
import '../../components/notifier.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  double lat = 0.0;
  double long = 0.0;

  bool _notext = false;

  void register(UserNotifier user) async {
    if (mobileController.text == '' ||
        passwordController.text == '' ||
        postalController.text == '' ||
        nameController.text == '') {
      _notext = true;
      return;
    }
    await http
        .get(Uri.parse(
            'https://developers.onemap.sg/commonapi/search?searchVal=${postalController.text}&returnGeom=Y&getAddrDetails=Y&pageNum=1'))
        .then((res) {
      var data = jsonDecode(res.body);
      lat = double.parse(data['results'][0]['LATITUDE']);
      long = double.parse(data['results'][0]['LONGITUDE']);
    });
    var data = {
      'name': nameController.text,
      'mobile': mobileController.text,
      'password': passwordController.text,
      'postal': postalController.text,
      'unit': unitController.text,
      'usertype': false,
      'block': postalController.text.substring(3),
      'lat': double.parse(lat.toStringAsFixed(5)),
      'long': double.parse(long.toStringAsFixed(5)),
      'exp': 0,
    };
    await http
        .post(
      Uri.parse('http://10.0.2.2:8000/api/users'),
      body: jsonEncode(
        data,
      ),
    )
        .then((res) {
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
      Navigator.of(context).pushNamed(TabScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginData = ModalRoute.of(context)!.settings.arguments as LoginData;
    mobileController.text = loginData.mobile;
    passwordController.text = loginData.password;
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
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'We just need a little more info!',
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
                    controller: mobileController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile',
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
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: postalController,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(),
                      errorText: _notext ? 'Please Key in all fields...' : null,
                      border: OutlineInputBorder(),
                      labelText: 'Postal Code',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: unitController,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(),
                      errorText: _notext ? 'Please Key in all fields...' : null,
                      border: OutlineInputBorder(),
                      labelText: 'Unit Number',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: double.infinity,
                  child:
                      Consumer<UserNotifier>(builder: (context, user, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                      child: Text('Login'),
                      onPressed: () async => register(user),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}