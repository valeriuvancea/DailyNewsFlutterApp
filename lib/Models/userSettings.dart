import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:daily_news/globals.dart';

class UserSettings {
  BuildContext context;
  static final ListTile deleteAccount = ListTile(
      title: new Center(
          child: Text('Delete account',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
      onTap: () {
        showAlertDialog(AlertDialog(
          title: new Text("Are you sure you want to delete your account?"),
          content: new Text("You are about to delete your account which will also delete all your favourites news." 
          +"This action is not reversible!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                log("yes");
                Navigator.of(globalContext).pop();
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                log("no");
                Navigator.of(globalContext).pop();
              },
            ),
          ],
        ));
      });

  static final ListTile logOff = ListTile(
      title: new Center(
          child: Text('Log off',
              style:
                  TextStyle(fontWeight: FontWeight.bold))),
      onTap: () {
        log('Log Off Pressed.');
      });

      
}
