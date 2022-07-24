// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, unnecessary_new, unnecessary_const

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('slogin', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
      child: new Container(
          color: Colors.white,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Home'),
                  ElevatedButton(
                    onPressed: () => _logOut(),
                    child: const Text('Logout',
                        style: const TextStyle(fontSize: 18)),
                  )
                ]),
          )),
    ));
  }
}
