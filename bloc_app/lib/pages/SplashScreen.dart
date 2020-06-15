import 'dart:async';

import 'package:bloc_app/pages/home.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class SplashScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return Scaffold(
      body: DecoratedMainContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(1.0),
                color: Colors.lightGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.shopping_basket, size: 60, color: Colors.greenAccent,),
                    ),
                    Text(
                      'Student Market', 
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          )
        )
      ),
    );
  }

  startTimer(BuildContext context) async {
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
    });
  }
}