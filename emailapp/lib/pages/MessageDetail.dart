import 'dart:convert';

import 'package:emailapp/components/CurveContainer.dart';
import 'package:emailapp/components/SideBarDrawer.dart';
import 'package:emailapp/models/MessageModel.dart';
import 'package:flutter/material.dart';

class MesageDetail extends StatefulWidget {
  MesageDetail({Key key, this.message}) : super(key: key);
  final Message message;
  @override
  _MesageDetailState createState() => _MesageDetailState();
}

class _MesageDetailState extends State<MesageDetail> {
  
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.message.subject),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            
          }),
        ],
      ),
      body: CurvedScreen(
        child: Container(
          padding: const EdgeInsets.all(16.0), 
          child: Text(
            widget.message.body, 
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      drawer: Drawer(
        child: SideBarDrawer()
      ),
    );
  }
}
