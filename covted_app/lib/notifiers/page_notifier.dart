import 'dart:async';
import 'package:covted_app/models/PageData.dart';
import 'package:covted_app/notifiers/user_notifier.dart';
import 'package:covted_app/pages/Auth.dart';
import 'package:covted_app/pages/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageNotifier extends ChangeNotifier {
  
  PageData _initialPage = (UserNotifier.getLoginStatus == false) ? PageData(page_title: 'Login Page', screen: AuthPage()) : PageData(page_title: 'Dashboard', screen: DashBoard());
  // PageData _initialPage = PageData(page_title: 'Login Page', screen: AuthPage());

  PageData _currentScreen;
  bool _isLoading = false;

  void set isLoading(bool isLoading) => _isLoading = isLoading;


  bool get getIsLoading => _isLoading;

  List<PageData> _visitedScreens = [];
  
  PageData get getPage => _initialPage;
  List<PageData> get getVisitedScreens => _visitedScreens;

  void set setPage(PageData page) => _initialPage = page;

  void changeLoading() {
    isLoading = !_isLoading;
    notifyListeners();
  }


  void changeScreen(BuildContext context, PageData page, {clear = false}) {
    print(clear);
    (clear == true) ? _visitedScreens = [] : _visitedScreens;
    print(_visitedScreens);
    _visitedScreens.add(_currentScreen);
    _currentScreen = page;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => page.screen));
    // print(_visitedScreens);
    setPage = page;
    notifyListeners();
  }

  void popScreen(BuildContext context) {
    // print(_visitedScreens);
    _currentScreen = _visitedScreens.last;
    _visitedScreens.removeLast();
    setPage = _currentScreen;
    Navigator.of(context).pop();
    notifyListeners();
  }

  ScreenNotifier() async {
    print(UserNotifier.getLoginStatus);
    _currentScreen = _initialPage;
    notifyListeners();
  }


  Future<bool> onBackPressed(BuildContext context) async {
    if (getVisitedScreens.length > 0) {
      popScreen(context);
      return Future.value(false);
    } else {
      bool close = await _onBackPressed(context);
      return Future.value(close);
    }
  }


  Future<bool> _onBackPressed(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Are you sure?'),
      content: Text('Do you want to exit an App'),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ),
      ],
    ),
  ) ?? false;
}



}