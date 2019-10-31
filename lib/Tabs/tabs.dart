import 'package:flutter/material.dart';
import 'package:daily_news/Tabs/userTab.dart';
import 'package:daily_news/Tabs/tabInterface.dart';
import 'package:daily_news/Tabs/newsTab.dart';
import 'package:daily_news/Tabs/bookmarksTab.dart';
import 'package:daily_news/globals.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key key}) : super(key: key);
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final List<TabInterface> tabList = <TabInterface>[
    new NewsTab(),
    new BookmarksTab(),
    new UserTab()
  ];

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return DefaultTabController(
        length: tabList.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: tabList.map((tab) => Tab(icon: tab.icon)).toList()
              ),
              title: Text('Daily News')
            ),
          body: TabBarView(
            children: tabList.cast(),
          ),
        ),
    );
  }
}