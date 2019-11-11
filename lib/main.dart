import 'package:flutter/material.dart';
import 'package:daily_news/Views/login.dart';
import 'package:daily_news/Views/tabs.dart';
import 'package:daily_news/globals.dart';

void main() async {
  await readUserId();
  if (userId == -1) {
    runApp(MaterialApp(home: Login()));
  }
  else
  {
    runApp(MaterialApp(home: Tabs()));
  }
}
