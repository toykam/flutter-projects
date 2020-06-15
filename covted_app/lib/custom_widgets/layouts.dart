import 'package:flutter/material.dart';

class PoppingPage extends StatelessWidget {
  PoppingPage({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: child,
    );
  }
}