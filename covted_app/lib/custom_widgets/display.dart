import 'package:covted_app/notifiers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarTitle extends StatelessWidget {
  AppBarTitle(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.display4);
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar(this.title);
  String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PreferredSize(
      child: AppBar(
        title: AppBarTitle(title),
      ), 
      preferredSize: null
    );
  }
}


class ProfileDisplayHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserNotifier _userNotifier = Provider.of<UserNotifier>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/image.png'),
          repeat: ImageRepeat.repeat,
          colorFilter: ColorFilter.matrix([
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 225,
            0.2126, 0.7152, 0.0722, 0, 0,
            0,      0,      0,      1, 0,
          ])
        )
      ),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/image2.jpg'),
              radius: 50,
            )
          ),
          Text(_userNotifier.getUserData.name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200)),
          Text('@${_userNotifier.getUserData.userName}', style: Theme.of(context).textTheme.title.apply(fontSizeDelta: 0.1)),
        ],
      ),
    );
  }
}