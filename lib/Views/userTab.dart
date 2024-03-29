import 'package:flutter/material.dart';
import 'package:daily_news/Models/userSettings.dart';
import 'package:daily_news/Models/tabInterface.dart';
import 'package:daily_news/globals.dart';

class UserTab extends StatefulWidget implements TabInterface {
  UserTab({Key key}) : super(key: key);
  
  final _icon = Icon(Icons.account_circle);
  get icon => _icon;
  set icon (Icon i) => icon = _icon;

  @override
  _UserTabState createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  final List<ListTile> menuList = <ListTile>[
    UserSettings.categories,
    UserSettings.logOff,
    UserSettings.deleteAccount
  ];

  @override
  Widget build(BuildContext context) {
    globalContext=context;
    return ListView.separated(
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          return menuList[index];
        },
        separatorBuilder: (context, index) {
          return Divider();
        });
  }
}
