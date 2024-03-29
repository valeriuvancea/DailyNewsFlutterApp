import 'package:flutter/material.dart';
import 'package:daily_news/globals.dart';
import 'package:daily_news/Models/category.dart';
import 'dart:convert';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Category> _categoryList = new List<Category>();
  bool _shouldLoad = true;
  String _error = "";

  @override
  void initState() {
    super.initState();
    sendHttpRequest(
            HttpRequestType.GET, serverApiURL + "/categories/$userId")
        .then((response) {
      if (response.statusCode == 200) {
        List<Category> temporaryList = new List<Category>();
        List<dynamic> responseList = json.decode(response.body);
        responseList.forEach((item) {
          temporaryList.add(new Category(item));
        });
        setState(() {
          _categoryList = temporaryList;
          _shouldLoad = false;
        });
      } else {
        setState(() {
          _shouldLoad = false;
          _error = "Internal server error. Please try again!";
        });
      }
    }).catchError((_) {
      setState(() {
        _error = "Network error.";
        _shouldLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    if (_shouldLoad) {
      return getLoadContainer();
    } else {
      if (_error.isNotEmpty) {
        return Scaffold(
            appBar: AppBar(title: Text("Categories")),
            body: getNetworkErrorTextWidget());
      } else {
        return Scaffold(
            appBar: AppBar(title: Text("Categories")),
            body: ListView.separated(
                itemCount: _categoryList.length + 1,
                itemBuilder: (context, index) {
                  if (index < _categoryList.length) {
                    final item = _categoryList[index];
                    return CheckboxListTile(
                        title: Text(item.title),
                        onChanged: (isCheked) {
                          if (isCheked) {
                            linkCategoryWithIdfromCurrentUser(item.categoryId);
                          } else {
                            unlinkCategoryWithIdfromCurrentUser(
                                item.categoryId);
                          }
                          setState(() {
                            item.isCategorySelected = isCheked;
                          });
                        },
                        value: item.isCategorySelected);
                  } else {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Align(
                            child: RaisedButton(
                              child: Text("Done"),
                              onPressed: () => Navigator.of(globalContext).pop(),
                              color: Colors.lightBlue,
                              textColor: Colors.white
                        )));
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider();
                }));
      }
    }
  }

  void unlinkCategoryWithIdfromCurrentUser(int categoryId) {
    modifyCategoryWithIdfromCurrentUser(categoryId, HttpRequestType.DELETE);
  }

  void linkCategoryWithIdfromCurrentUser(int categoryId) {
    modifyCategoryWithIdfromCurrentUser(categoryId, HttpRequestType.POST);
  }

  void modifyCategoryWithIdfromCurrentUser(
      int categoryId, HttpRequestType httpRequestType) {
    sendHttpRequest(httpRequestType,
            serverApiURL + "/users/$userId/" + categoryId.toString())
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = json.decode(response.body);
        if (responseMap["rowsAffected"][0] == 1) {
          setState(() {
            _categoryList[_categoryList.indexWhere((category) {
              return category.categoryId == categoryId;
            })]
                .isCategorySelected = httpRequestType == HttpRequestType.POST;
          });
        }
      }
    }).catchError((_) {
      showNetworkErrorDialog();
      setState(() {
        _categoryList[_categoryList.indexWhere((category) {
          return category.categoryId == categoryId;
        })]
            .isCategorySelected = httpRequestType == HttpRequestType.DELETE;
      });
    });
  }
}
