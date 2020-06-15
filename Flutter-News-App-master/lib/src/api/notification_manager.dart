//import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//class NotificationManager {
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//  get onDidReceiveLocalNotification => null;
//  void initialize() async {
//    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//    var initializationSettingsAndroid = AndroidInitializationSettings('logo');
//    var initializationSettingsIOS = IOSInitializationSettings(
//        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    var initializationSettings = InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: selectNotification);
//  }
//
//  showNotification() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future selectNotification(String payload) async {
//    if (payload != null) {
//      debugPrint('notification payload: ' + payload);
//    }
//  }
//
//  NotificationManager() {
//    initialize();
//  }
//}
