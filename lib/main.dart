// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import './login.dart';
import './home.dart';
import './launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LauncherPage(),
      routes: <String, WidgetBuilder>{
        // ignore: prefer_const_constructors
        '/login': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomePage(),
      },
    );
  }
}
