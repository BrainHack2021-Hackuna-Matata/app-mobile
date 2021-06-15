import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/notifier.dart';
import './screens/exerciseScreen/exerciseSelectionsScreen.dart';
import './screens/authScreen/authScreen.dart';
import './screens/authScreen/registerScreen.dart';
import './screens/meetupScreen/meetupListScreen.dart';
import './screens/purchasescreen/purchaseSplash.dart';
import './screens/tabScreen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationNotifier()),
        ChangeNotifierProvider(create: (context) => UserNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String _title = "ElderlyApp";

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget._title,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: AuthScreen(),
      initialRoute: "/",
      routes: {
        "/meet": (context) => MeetupListScreen(),
        "/purchase": (context) => PurchaseSplash(),
        "/exercise": (context) => ExerciseSelectionsScreen(),
        TabScreen.routeName: (context) => TabScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
      },
    );
  }
}
