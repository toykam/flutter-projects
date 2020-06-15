import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/ui/home/blogger_home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BloggerHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
