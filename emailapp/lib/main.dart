import 'package:emailapp/pages/App.dart';
import 'package:flutter/material.dart';

void main() => runApp(EmailApp());


class EmailApp extends StatefulWidget {
  EmailApp({Key key}) : super(key: key);

  @override
  _EmailAppState createState() => _EmailAppState();
}

class _EmailAppState extends State<EmailApp> {

  Widget page = App();
  String title = "Inbox";

  @override
  Widget build(BuildContext context) {
    return App();
  }
}
