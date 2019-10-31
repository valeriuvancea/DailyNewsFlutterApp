import 'package:flutter/material.dart';
import 'package:daily_news/Tabs/tabInterface.dart';

class BookmarksTab extends StatefulWidget implements TabInterface {
  BookmarksTab({Key key}) : super(key: key);

  final _icon = Icon(Icons.bookmark);
  get icon => _icon;
  set icon (Icon i) => icon = _icon;

  @override
  _BookmarksTabState createState() => _BookmarksTabState();
}

class _BookmarksTabState extends State<BookmarksTab> {
  @override
  Widget build(BuildContext context) {
    return Text("bookmarks");
  }
}