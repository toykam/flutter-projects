import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodclip/notifier/login_notifier.dart';
import 'package:foodclip/pages/login.dart';
import 'package:foodclip/utils/constants.dart';
import 'package:foodclip/utils/page_routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends ChangeNotifier {
  bool _isLoggedIn;

  String _userName;
  String _userEmail;
  String _userPassword;
  String _dipatches = '0';
  bool loading = true;

  bool get userIsLoggedIn => _isLoggedIn;
  String get getUserDispatches => _dipatches;

  set _userIsLoggedIn(bool status) => _isLoggedIn = status;
  set _setUserDispatches(String dispatches) => _dipatches = dispatches;

  void logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message'),
          content: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            child: Column(
              children: <Widget>[
                Text('Do you want to logout?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      elevation: 2,
                      color: Colors.green,
                      onPressed: () async {
                        SharedPreferences _sharedPref = await SharedPreferences.getInstance();
                        await _sharedPref.setBool(USER_ONLINE_KEY, false);

                        Navigator.of(context).pushReplacement(
                          FadeRoute(
                            page: ChangeNotifierProvider(
                              create: (context) => LoginNotifier(),
                              child: LoginPage()
                            )
                          )
                        );
                      },
                      child: Text('Yes'),
                    ),
                    MaterialButton(
                      elevation: 2,
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    )
                  ],
                ),
              ],
            ),
          )
        );
      }
    );
  }

  void initialize() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    _userIsLoggedIn = _sharedPref.getBool(USER_ONLINE_KEY);
    _setUserDispatches = _sharedPref.getString(USER_DISPATCHES_KEY);
    loading = false;
    notifyListeners();
  }

  void update() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) async {
      initialize();
    });
  }

  UserNotifier() {
    initialize();
    update();
  }
}