import 'package:emailapp/pages/CalendarScreen.dart';
import 'package:emailapp/pages/ContactScreen.dart';
import 'package:emailapp/pages/Inbox_screen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MailBox",
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.white,
      ),
      home: Scaffold(
        body: [
          InboxScreen(),
          ContactScreen(),
          CalendarScreen(),
        ].elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(title: Text('Inbox'), icon: Icon(Icons.inbox)),
            BottomNavigationBarItem(title: Text('Contact'), icon: Icon(Icons.people)),
            BottomNavigationBarItem(title: Text('Calendar'), icon: Icon(Icons.calendar_today)),
          ]
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
