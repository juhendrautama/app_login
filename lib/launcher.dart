// ignore_for_file: unnecessary_new, prefer_const_constructors, unnecessary_const
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import './home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './login.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key key}) : super(key: key);

  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    final prefs = await SharedPreferences.getInstance();
    bool login;
    login = prefs.getBool('login') ?? false;

    var duration = const Duration(seconds: 3);
    return new Timer(duration, () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
        return login ? new HomePage() : new LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 72, 194, 251),
    ));
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromARGB(255, 119, 117, 117),
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 136, 220, 231),
                  Color.fromARGB(255, 122, 120, 233)
                ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(child: Text("SELMAT DATANG DI APLIKASI SIGADIS")),
          ],
        ),
      ),
    );
  }
}
