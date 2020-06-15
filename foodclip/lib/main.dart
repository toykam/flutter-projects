import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodclip/notifier/login_notifier.dart';
import 'package:foodclip/pages/login.dart';
import 'package:foodclip/utils/constants.dart';
import 'package:foodclip/utils/page_routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notifier/user_notifier.dart';
import 'pages/dashboard.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserNotifier(),
      ),
    ],
    child: MyApp()
  )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Food Clique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: (_userNotifier.userIsLoggedIn == true) ? DashboardScreen() : LoginPage(),
      // home: LoginPage(),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.8),
      extendBody: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/splash.jpg'),
              )
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.green.withOpacity(0.8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: 20,),
                  Text('Proudly Supported by', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/avi.jpg',
                      ),
                      CircularProgressIndicator(),
                      Image.asset(
                        'assets/images/techend.jpg',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}


void startTimer(BuildContext context) async {
  SharedPreferences _sharedPref = await SharedPreferences.getInstance();
  bool loggedIn = _sharedPref.getBool(USER_ONLINE_KEY);
  Widget page  = (loggedIn == true) ? DashboardScreen() : ChangeNotifierProvider(create: (context) => LoginNotifier(),child: LoginPage());
  Timer(Duration(seconds: 5), () => Navigator.of(context).pushReplacement(FadeRoute(page: page)));
  // Timer(Duration(seconds: 5), Navigator.)
}