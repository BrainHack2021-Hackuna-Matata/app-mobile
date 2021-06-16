import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './authScreen.dart';
import '../../api/static.dart';
import '../../components/notifier.dart';
import '../../models/user.dart';
import '../tabScreen.dart';

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
  bool _usertype = false;
  bool _postalerror = false;

  void register(UserNotifier user) async {
    if (mobileController.text == '' || passwordController.text == '' || postalController.text == '' || nameController.text == '') {
      setState(() {
        _notext = true;
      });
      return;
    }
    await http.get(Uri.parse('https://developers.onemap.sg/commonapi/search?searchVal=${postalController.text}&returnGeom=Y&getAddrDetails=Y&pageNum=1')).then((res) {
      var data = jsonDecode(res.body);
      lat = double.parse(data['results'][0]['LATITUDE']);
      long = double.parse(data['results'][0]['LONGITUDE']);
      setState(() {
        _postalerror = false;
      });
    }).catchError(
      (error) {
        setState(() {
          _postalerror = true;
        });
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Invalid Postal Code',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            content: const Text(
              'Please ensure that the postal code you have entered is a correct one.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
    if (_postalerror) {
      return;
    }
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
      Uri.parse('${Api.CURR_URL}/users'),
      body: jsonEncode(
        data,
      ),
    )
        .then(
      (res) {
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
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginData = ModalRoute.of(context)!.settings.arguments as LoginData;
    mobileController.text = loginData.mobile;
    passwordController.text = loginData.password;
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(10,0,10,0),
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
                      errorStyle: TextStyle(),
                      errorText: _notext ? 'Please Key in all fields...' : null,
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
                      errorStyle: TextStyle(),
                      errorText: _notext ? 'Please Key in all fields...' : null,
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
                      errorStyle: TextStyle(),
                      errorText: _notext ? 'Please Key in all fields...' : null,
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
                    controller: unitController,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(),
                      errorText: _notext ? 'Please Key in all fields...' : null,
                      border: OutlineInputBorder(),
                      labelText: 'Unit Number',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: ListTile(
                          title: const Text('Elderly'),
                          leading: Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: false,
                            groupValue: _usertype,
                            onChanged: (value) {
                              setState(() {
                                _usertype = value as bool;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: ListTile(
                          title: const Text('GroupBuyer'),
                          leading: Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: true,
                            groupValue: _usertype,
                            onChanged: (value) {
                              setState(() {
                                _usertype = value as bool;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: double.infinity,
                  child: Consumer<UserNotifier>(builder: (context, user, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                      ),
                      child: Text('Register'),
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
