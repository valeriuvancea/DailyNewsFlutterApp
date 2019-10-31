import 'package:flutter/material.dart';
BuildContext globalContext;
final String appTitle = "Daily News";

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