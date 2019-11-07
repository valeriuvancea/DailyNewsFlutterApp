import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:daily_news/Views/login.dart';
import 'package:daily_news/Views/tabs.dart';

BuildContext globalContext;
final String appTitle = "Daily News";
final String serverApiURL = "https://dailynews.azurewebsites.net/api";
int userId = -1;

enum HttpRequestType { GET, POST, DELETE }

void showAlertDialog(AlertDialog alertDialog) {
  if (globalContext == null) {
    return;
  }
  showDialog(
      context: globalContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return alertDialog;
      });
}

Future<http.Response> sendHttpRequest(HttpRequestType requestType, String url) {
  switch (requestType) {
    case HttpRequestType.GET:
      return http.get(url);

    case HttpRequestType.POST:
      return http.post(url);

    case HttpRequestType.DELETE:
      return http.delete(url);

    default:
      return null;
  }
}

Widget getLoadContainer() {
  return Container(
    color: Colors.lightBlue,
    child: Center(
      child: Loading(indicator: BallPulseIndicator(), size: 100.0),
    ),
  );
}

Future<String> getLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> getLocalFile() async {
  final path = await getLocalPath();
  return File('$path/userId.txt');
}

Future<File> writeUserId(int id) async {
  userId = id;
  final file = await getLocalFile();
  return file.writeAsString('$id');
}

Future<File> clearStorageFile() async {
  final file = await getLocalFile();
  return file.writeAsString('');
}

void readUserId() async {
  try {
    final file = await getLocalFile();
    String contents = await file.readAsString();
    userId = int.parse(contents);
  } catch (e) {
    userId = -1;
  }
}

void logOffAndClearStorageFile() {
  clearStorageFile();
  Navigator.of(globalContext).pushReplacement(
    MaterialPageRoute(builder: (globalContext) => Login()),
  );
}

Future loginWithUserId(int id) async {
  await writeUserId(id);
  Navigator.of(globalContext).pushReplacement(
    MaterialPageRoute(builder: (globalContext) => Tabs()),
  );
}

void showNetworkErrorDialog() {
  showAlertDialog(AlertDialog(
      title: Text("Newtork error!"),
      content: Text(
          "Newtork error! Please try again and make sure you have internet connection!"),
      actions: <Widget>[
        FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(globalContext).pop();
            })
      ]));
}

Widget getNetworkErrorTextWidget() {
  return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
          child: Text(
              'Network error. Please try again and make sure you have internet connection!',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
              textAlign: TextAlign.center)));
}
