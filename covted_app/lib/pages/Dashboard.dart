import 'package:covted_app/custom_widgets/display.dart';
import 'package:covted_app/custom_widgets/layouts.dart';
import 'package:covted_app/notifiers/page_notifier.dart';
import 'package:covted_app/notifiers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageNotifier _pageNotifier = Provider.of<PageNotifier>(context);
    UserNotifier _userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: AppBarTitle('Dashboard'),
        actions: <Widget>[
          Text(_pageNotifier.getVisitedScreens.length.toString(), style: Theme.of(context).textTheme.display4,)
        ],
      ),
      body: PoppingPage(
        child: Column(
          children: <Widget>[
            ProfileDisplayHeader(),
            Container(
              child: Text('Dashboard'),
            )
          ],
        ),
      )
    );
  }
}