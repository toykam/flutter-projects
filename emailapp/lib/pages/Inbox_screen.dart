import 'package:emailapp/components/CurveContainer.dart';
import 'package:emailapp/components/MessageList.dart';
import 'package:emailapp/components/SideBarDrawer.dart';
import 'package:flutter/material.dart';


class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Theme.of(context).accentColor,), 
              onPressed: null,
              color: Theme.of(context).accentColor,
            )
          ],
          bottom: TabBar(tabs: <Tab>[
            Tab(text: 'Important'),
            Tab(text: 'Others'),
          ]),
        ),
        drawer: SideBarDrawer(),
        body: CurvedScreen(
          child: TabBarView(
            children: <Widget>[
              MessageList(),
              MessageList(),
            ]
          ),
        ),
      )
    );
  }

}