import 'package:flutter/material.dart';
import 'package:daily_news/globals.dart';
import 'dart:developer';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _username = "";
  String _password = "";
  String _confirmedPassword = "";
  
  final focusPassword = FocusNode();
  final focusConfirmPassword = FocusNode();

  void register() {
    log(_username);
    log(_password);
    log(_confirmedPassword);
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
              'Register',
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
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (x) {
                  FocusScope.of(context).requestFocus(focusConfirmPassword);
                },
                focusNode: focusPassword,
                onChanged: (password) => _password = password,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password")),
            TextFormField(
                onFieldSubmitted: (x) => register(),
                focusNode: focusConfirmPassword,
                onChanged: (confirmedPassword) => _confirmedPassword = confirmedPassword,
                obscureText: true,
                decoration: InputDecoration(labelText: "Confirm password")),
            SizedBox(height: 20.0),
            RaisedButton(
                child: Text("Register"),
                onPressed: () => register()),
          ],
        ),
      ),
    );
  }
}
