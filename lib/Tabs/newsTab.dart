import 'package:flutter/material.dart';
import 'package:daily_news/Tabs/tabInterface.dart';

class NewsTab extends StatefulWidget implements TabInterface {
  NewsTab({Key key}) : super(key: key);

  final _icon = Icon(Icons.all_inclusive);
  get icon => _icon;
  set icon (Icon i) => icon = _icon;

  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  @override
  Widget build(BuildContext context) {
    return Text("news");
  }
}