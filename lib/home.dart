// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, unnecessary_new, unnecessary_const
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;
  String user;
  @override
  void initState() {
    super.initState();
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(user);
    prefs.setBool('login', false);
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
                  const SizedBox(height: 20.0),
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
