import 'package:flutter/material.dart';
import 'package:daily_news/globals.dart';
import 'package:daily_news/Views/register.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

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
  bool _shouldLoad = false;

  void login() {
    setState(() {
      _shouldLoad = true;
    });
    final String url = serverApiURL +
        '/users?username=' +
        _username +
        '&password=' +
        md5.convert(utf8.encode(_password)).toString();

    sendHttpRequest(HttpRequestType.GET, url).then((response) {
      String temporaryError = "";
      if (response.statusCode == 200) {
        loginWithUserId(json.decode(response.body)[0]["userId"]);
      } else {
        temporaryError = json.decode(response.body)["error"];
      }
      setState(() {
        _error = temporaryError;
        _shouldLoad = false;
      });
    }).catchError((_) {
      setState(() {
        _error =
            "Network error. Please try again and make sure you have internet connection!";
        _shouldLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    if (_shouldLoad) {
      return getLoadContainer();
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(appTitle)),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(fontSize: 25),
              ),
              Visibility(
                child: Text(
                  "Error: " + _error,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                visible: _error.isNotEmpty,
              ),
              TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Login"),
                      onPressed: () => login(),
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                    ),
                    SizedBox(width: 50.0),
                    InkWell(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                      onTap: () => Navigator.of(globalContext).push(
                        MaterialPageRoute(builder: (context) => Register()),
                      ),
                    )
                  ])
            ],
          ),
        ),
      );
    }
  }
}
