import 'package:flutter/material.dart';
import 'package:daily_news/globals.dart';
import 'package:daily_news/Views/categories.dart';

class UserSettings {
  static final ListTile deleteAccount = ListTile(
      title: new Center(
          child: Text('Delete account',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
      onTap: () {
        showAlertDialog(AlertDialog(
          title: Text("Are you sure you want to delete your account?"),
          content: Text(
              "You are about to delete your account which will also delete all your favourites news." +
                  "This action is not reversible!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                sendHttpRequest(HttpRequestType.DELETE,
                        serverApiURL + "/users/$userId")
                    .then((request) {
                  if (request.statusCode == 200) {
                    logOffAndClearStorageFile();
                  } else {
                    Navigator.of(globalContext).pop();
                    showAlertDialog(AlertDialog(
                        title: Text("Unable to delete user!"),
                        content: Text("Due to a server error, the user was not deleted!"),
                        actions: <Widget>[
                          FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(globalContext).pop();
                              })
                        ]));
                  }
                }).catchError((_) {
                  showNetworkErrorDialog();
                });
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(globalContext).pop();
              },
            ),
          ],
        ));
      });

  static final ListTile logOff = ListTile(
      title: new Center(
          child:
              Text('Log off', style: TextStyle(fontWeight: FontWeight.bold))),
      onTap: () {
        logOffAndClearStorageFile();
      });

  static final ListTile categories = ListTile(
      title: new Center(
          child: Text('Categories',
              style: TextStyle(fontWeight: FontWeight.bold))),
      onTap: () {
        Navigator.of(globalContext).push(
          MaterialPageRoute(builder: (globalContext) => Categories()),
        );
      });
}
