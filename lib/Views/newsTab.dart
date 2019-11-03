import 'package:flutter/material.dart';
import 'package:daily_news/Models/tabInterface.dart';
import 'package:daily_news/Models/news.dart';
import 'package:daily_news/globals.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class NewsTab extends StatefulWidget implements TabInterface {
  NewsTab({Key key}) : super(key: key);

  final _icon = Icon(Icons.format_align_justify);
  get icon => _icon;
  set icon(Icon i) => icon = _icon;

  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  List<News> _newsList = new List<News>();
  bool _shouldLoad = true;
  bool _disposed = false;
  String _error = "";

  @override
  void initState() {
    super.initState();
    sendHttpRequest(HttpRequestType.GET, serverApiURL + "/users/$userId/news")
        .then((response) {
      if (response.statusCode == 200) {
        List<News> temporaryList = new List<News>();
        List<dynamic> responseList = json.decode(response.body);

        responseList.forEach((item) {
          temporaryList.add(new News(item));
        });
        if (!_disposed) {
          setState(() {
            _newsList = temporaryList;
            _shouldLoad = false;
          });
        }
      }
    }).catchError((_) {
      setState(() {
        _shouldLoad = false;
        _error = "Internal server error. Please try again!";
      });
    });
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;

    if (_shouldLoad) {
      return getLoadContainer();
    } else if (_error.isNotEmpty) {
      return getNetworkErrorTextWidget();
    } else if (_newsList.isEmpty) {
      return Center(
          child: Text('There are no news',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)));
    }
    return ListView.separated(
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          final item = _newsList[index];
          return ListTile(
            title: Text(
              item.title,
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.blue),
            ),
            subtitle: Text("Category: " +
                item.category +
                "\nPublication date: " +
                item.publicationDate),
            onTap: () {
              _launchURL(item.link);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
