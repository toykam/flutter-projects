import 'package:covted_app/custom_widgets/display.dart';
import 'package:covted_app/notifiers/auth_page_notifier.dart';
import 'package:covted_app/notifiers/page_notifier.dart';
import 'package:covted_app/pages/LoginPage.dart';
import 'package:covted_app/pages/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  AuthPage({this.index});
  final int index;
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController();
  }

  @override
  Widget build(BuildContext context) {
    PageNotifier _pageNotifier = Provider.of<PageNotifier>(context);
    AuthPageNotifier _authPageNotifier = Provider.of<AuthPageNotifier>(context);
    // print('From Auth Page: '+_authPageNotifier.getCurrentIndex.toString());
    return DefaultTabController(
      initialIndex: _authPageNotifier.getCurrentIndex,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: AppBarTitle('Covted Challenge Test'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _pageNotifier.popScreen(context);
            },
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Text('Login'),
            ),
            Tab(
              child: Text('Register'),
            )
          ]),
        ),
        body: TabBarView(children: [LoginPage(), RegisterPage()]),
      ),
      length: 2,
    );
  }
}
