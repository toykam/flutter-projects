import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyScreenProvider extends StatelessWidget {
  MyScreenProvider(this.child, this.notifier);
  final Widget child;
  final ChangeNotifier notifier;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => notifier,
      child: child,
    );
  }
}