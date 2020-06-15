import 'package:flutter/material.dart';


class CurvedScreen extends StatelessWidget {
  CurvedScreen({this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0)
          )
        ),
        child: child,
      ),
    );
  }
}