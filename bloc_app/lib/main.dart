import 'package:bloc_app/notifiers/cart_notifier.dart';
import 'package:bloc_app/notifiers/counter_notifier.dart';
import 'package:bloc_app/notifiers/order_notifier.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/notifiers/product_notifier.dart';
import 'package:bloc_app/notifiers/todo_notifier.dart';
import 'package:bloc_app/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => ScreenNotifier()
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => CounterNotifier()
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => TodoNotifier()
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => OrderNotifier()
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => ProductNotifier()
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => CartNotifier()
      )
    ],
    child: MyApp(),
  )
  
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ScreenNotifier screenNotifier = Provider.of<ScreenNotifier>(context);
    return MaterialApp(
        title: 'Student Market',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          textTheme: TextTheme(
            display4: TextStyle(fontSize: 40)
          )
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      );
  }
}
