import 'package:flutter/material.dart';
import 'package:daily_news/globals.dart';
import 'package:crypto/crypto.dart';
import 'package:daily_news/Views/categories.dart';
import 'package:daily_news/Views/tabs.dart';
import 'dart:convert';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _username = "";
  String _password = "";
  String _confirmedPassword = "";
  String _error = "";
  bool _shouldLoad = false;

  final focusPassword = FocusNode();
  final focusConfirmPassword = FocusNode();

  void register() {
    setState(() {
      _shouldLoad = true;
    });
    if (_username.isEmpty || _password.isEmpty || _confirmedPassword.isEmpty) {
      setState(() {
        _error = "All fields are required!";
        _shouldLoad = false;
      });
    } else if (_password != _confirmedPassword) {
      setState(() {
        _error = "The given passwords does not match!";
        _shouldLoad = false;
      });
    } else {
      final String url = serverApiURL +
          '/users?username=' +
          _username +
          '&password=' +
          md5.convert(utf8.encode(_password)).toString();
      sendHttpRequest(HttpRequestType.POST, url).then((response) {
        String temporaryError = "";
        if (response.statusCode == 200) {
          Future(() async {
            await writeUserId(json.decode(response.body)[0]["userId"]);
          }).then((_) {
            Navigator.of(globalContext)
                .push(
              MaterialPageRoute(builder: (globalContext) => Categories()),
            )
                .then((_) {
              Navigator.of(globalContext).pushReplacement(
                MaterialPageRoute(builder: (globalContext) => Tabs()),
              );
            });
          });
        } else {
          temporaryError = "The username allready exists!";
        }
        setState(() {
          _error = temporaryError;
          _shouldLoad = false;
        });
      }).catchError((_) {
        setState(() {
          _error = "Network error.";
          _shouldLoad = false;
        });
      });
    }
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
                'Register',
                style: TextStyle(fontSize: 25),
              ),
              Visibility(
                child: Text("Error: " + _error,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                visible: _error.isNotEmpty,
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
                  onChanged: (confirmedPassword) =>
                      _confirmedPassword = confirmedPassword,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Confirm password")),
              SizedBox(height: 20.0),
              RaisedButton(
                  child: Text("Register"), onPressed: () => register()),
            ],
          ),
        ),
      );
    }
  }
}
