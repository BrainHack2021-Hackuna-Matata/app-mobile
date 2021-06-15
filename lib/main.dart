import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/notifier.dart';
import 'screens/exerciseScreen/exerciseSelectionsScreen.dart';
import 'screens/tabScreen.dart';
import 'screens/meetupScreen/meetupListScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationNotifier()),
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
      home: TabScreen(),
      initialRoute: "/",
      routes: {
        "/meet": (context) => MeetupListScreen(),
        "/purchase": (context) => TabScreen(),
        "/exercise": (context) => ExerciseSelectionsScreen(),
      },
    );
  }
}
