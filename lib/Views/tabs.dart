import 'package:flutter/material.dart';
import 'package:daily_news/Views/userTab.dart';
import 'package:daily_news/Models/tabInterface.dart';
import 'package:daily_news/Views/newsTab.dart';
import 'package:daily_news/globals.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key key}) : super(key: key);
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final List<TabInterface> tabList = <TabInterface>[
    new NewsTab(),
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
              title: Text(appTitle)
            ),
          body: TabBarView(
            children: tabList.cast(),
          ),
        ),
    );
  }
}