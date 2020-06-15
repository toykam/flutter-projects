import 'package:covted_app/notifiers/auth_page_notifier.dart';
import 'package:covted_app/notifiers/page_notifier.dart';
import 'package:covted_app/notifiers/user_notifier.dart';
import 'package:covted_app/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PageNotifier()
      ),
      ChangeNotifierProvider(
        create: (context) => UserNotifier()
      ),
      ChangeNotifierProvider(
        create: (context) => AuthPageNotifier()
      )
    ],
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covted Challenge App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: TextTheme(
          display4: TextStyle(fontSize: 40)
        )
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

