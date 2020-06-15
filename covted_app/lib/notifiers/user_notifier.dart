import 'package:covted_app/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends ChangeNotifier {
  static bool _loggedInStatus;
  User _userData;
  SharedPreferences pref;

  User get getUserData => _userData;

  static bool get getLoginStatus => _loggedInStatus;
  
  set _setUserData(User userData) {
    _userData = userData;
    _loggedInStatus = true;
  }

  Future<User> login(User userData) async {
    _setUserData = userData;
    // print(userData);
    pref.setBool('isLoggedIn', true);
    pref.setString('name', userData.name);
    pref.setString('email', userData.email);
    notifyListeners();
    return userData;
  }

  void register(User userdata) {
    // pref.setStringList('userData', []);
    pref.setString('name', userdata.name);
    pref.setString('email', userdata.email);
    pref.setString('username', userdata.userName);
    pref.setString('level', '100 Level');
    pref.setString('phoneNumber', userdata.phoneNumber.toString());
  }

  void logout() {
    _userData = null;
    _loggedInStatus = false;
    notifyListeners();
  }

  initialize() async {
    pref = await SharedPreferences.getInstance();
    _loggedInStatus = pref.getBool('isLoggedIn') ? pref.getBool('isLoggedIn') : false;
    print('Logged in status: '+_loggedInStatus.toString());
    _userData = _loggedInStatus == true ? User(name: pref.getString('name'), email: pref.getString('email')) : null;
    notifyListeners();
  }

  UserNotifier() {
    initialize();
  }
}