import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Center(child: Text('Alaye How Far?'),), 
        preferredSize: MediaQuery.of(context).size,
      ),
      body: Hero(
        tag: 'adhkar',
              child: Container(
        child: Center(child: Text('Second Page Body'),),
        ),
      ),
    );
  }
}