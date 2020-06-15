import 'package:bloc_app/models/page_data.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/pages/ProfilePage.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenNotifier _screenNotifier = Provider.of<ScreenNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle('Page Two'),
        actions: <Widget>[
          Text(_screenNotifier.getVisitedScreens.length.toString(), style: Theme.of(context).textTheme.display4,)
        ],
      ),
      body: PoppingPage(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                heroTag: 'profile',
                onPressed: () => _screenNotifier.changeScreen(context, PageData(page_title: 'Profile Page', screen: ProfilePage())),
                tooltip: 'Profile',
                child: Icon(Icons.person),
              ),
            ),
          ),
        ),
      )
    );
  }
}