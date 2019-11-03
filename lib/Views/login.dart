import 'package:flutter/material.dart';
import 'package:daily_news/globals.dart';
import 'dart:developer';
import 'package:daily_news/Views/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:daily_news/Views/tabs.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _username = "";
  String _password = "";
  final focusPassword = FocusNode();
  String _error = "";
  bool _errorVisibility = false;

  void login() {
    log(_username);
    log(_password);
    fetchPost(_username, _password).then((response) {
      if (response.statusCode == 200) {
        Navigator.of(globalContext).pushReplacement(
          MaterialPageRoute(builder: (globalContext) => Tabs()),
        );
      }
      log(response.toString());
    });
    setState(() {
      _error = "error";
      _errorVisibility = true;
    });
  }

  String inputWithNameandValueNotEmptyValidation(String name, String value) {
    if (value.isEmpty) {
      _errorVisibility = true;
      return 'Please enter the ' + name;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
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
            Visibility(
              child: Text(_error),
              visible: _errorVisibility,
            ),
            TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (x) {
                  FocusScope.of(context).requestFocus(focusPassword);
                },
                onChanged: (username) => _username = username,
                decoration: InputDecoration(labelText: "UserName"),
                validator: (value) =>
                    inputWithNameandValueNotEmptyValidation("UserName", value)),
            TextFormField(
                focusNode: focusPassword,
                onChanged: (password) => _password = password,
                onFieldSubmitted: (password) => login(),
                obscureText: true,
                decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 10.0),
            RaisedButton(child: Text("Login"), onPressed: () => login()),
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

Future<http.Response> fetchPost(username, password) {
  return http.get('https://daily-news-server.herokuapp.com/users?username=' +
      username +
      '&password=' +
      md5.convert(utf8.encode(password)).toString());
}
