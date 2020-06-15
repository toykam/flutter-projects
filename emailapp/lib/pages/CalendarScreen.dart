import 'package:emailapp/components/CurveContainer.dart';
import 'package:emailapp/components/SideBarDrawer.dart';
import 'package:flutter/material.dart';


class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        elevation: 0,
      ),
      drawer: SideBarDrawer(),
      body: CurvedScreen(
              child: Container(
          child: Center(
            child: StreamBuilder<int>(
              builder: (context, snapshot) {
                return Text((snapshot.data ?? 0).toString());
              }
            ),
          ),
        ),
      )
    );
  }
}