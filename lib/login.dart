// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './api_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool visible = false;
  String user;
  String pass;
  String pesan = '';
  SharedPreferences prefs;

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  saveSession(
    String user,
  ) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('user', user);
      prefs.setBool('login', true);
    });
  }

  void prosesLogin(String user, String pass) async {
    setState(() {
      user = userNameController.text;
      pass = passwordController.text;
    });
    ApiLogin.login(user, pass).then((value) {
      if (value.response == 1) {
        saveSession(user);
        pesan = value.pesan;
      } else {
        pesan = value.pesan;
      }
    });
  }

  void reset() {
    setState(() {
      pesan = '';
    });
    userNameController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0),
                  )),
              const SizedBox(height: 20.0),
              TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0),
                  )),
              const SizedBox(height: 20.0),

              Text(
                "$pesan",
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              //Tombol
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      prosesLogin(
                          userNameController.text, passwordController.text);
                    },
                    child: const Text("LOGIN"),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(onPressed: reset, child: const Text("RESET")),
                ],
              ),

              //Tombol
            ],
          ),
        ),
      ),
    ));
  }
}
