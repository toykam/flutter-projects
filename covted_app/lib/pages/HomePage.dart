import 'package:covted_app/notifiers/page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PageNotifier _pageNotifier = Provider.of<PageNotifier>(context);
    return _pageNotifier.getPage.screen;
  }
}
