import 'package:bloc_app/notifiers/counter_notifier.dart';
import 'package:bloc_app/pages/CounterPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CounterNotifier(),
      child: CounterPage(),
    );
  }
}