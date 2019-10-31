import 'package:flutter/material.dart';
import 'package:daily_news/globals.dart';
import 'dart:developer';
import 'package:daily_news/Views/register.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = "";
  String _password = "";
  final focusPassword = FocusNode();

  void login() {
    log(_username);
    log(_password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (x) {
                  FocusScope.of(context).requestFocus(focusPassword);
                },
                onChanged: (username) => _username = username,
                decoration: InputDecoration(labelText: "UserName")),
            TextFormField(
                focusNode: focusPassword,
                onChanged: (password) => _password = password,
                onFieldSubmitted: (password) => login(),
                obscureText: true,
                decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 10.0),
            RaisedButton(
                child: Text("Login"),
                onPressed: () => login()),
            SizedBox(height: 5.0),
            InkWell(
              child: Text(
                "Register",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
