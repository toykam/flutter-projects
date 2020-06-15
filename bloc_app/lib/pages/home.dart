import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenNotifier screenNotifier = Provider.of<ScreenNotifier>(context, listen: false);
    print(screenNotifier.getVisitedScreens.length);
    return screenNotifier.getPage.screen;
  }
}