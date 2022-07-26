// ignore_for_file: unnecessary_string_interpolations, unnecessary_import, avoid_print, unnecessary_const
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './api_login.dart';
import 'package:progress_dialog/progress_dialog.dart';
import './home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  ProgressDialog progressDialog;
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

  dalletSession(
    String user,
  ) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove(user);
    });
  }

  void prosesLogin(String user, String pass) async {
    await progressDialog.show();
    prefs = await SharedPreferences.getInstance();
    setState(() {
      ApiLogin.login(user, pass).then((value) {
        if (value.response == 1) {
          progressDialog.hide();
          saveSession(user);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        } else if (value.response == 2) {
          progressDialog.hide();
          dalletSession('user');
          pesan = value.pesan;
          AlertDialog alert2 = AlertDialog(
            title: const Text("Warning !!"),
            content: Text("$pesan"),
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert2;
            },
          );
        } else {
          progressDialog.hide();
          dalletSession('user');
          pesan = value.pesan;
          AlertDialog alert2 = AlertDialog(
            title: const Text("Warning !!"),
            content: Text("$pesan"),
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert2;
            },
          );
        }
      });
    });
  }

  reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove("user");
      pesan = '';
      userNameController.clear();
      passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );
    progressDialog.style(message: 'tunggu');

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
              //Tombol
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (userNameController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        AlertDialog alert = const AlertDialog(
                          title: const Text("Warning !!"),
                          content:
                              const Text("Masukkan Username dan Password!"),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else {
                        prosesLogin(
                            userNameController.text, passwordController.text);
                      }
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
