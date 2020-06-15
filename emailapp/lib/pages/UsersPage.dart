import 'dart:convert';

import 'package:emailapp/components/CurveContainer.dart';
import 'package:emailapp/components/UserTile.dart';
import 'package:emailapp/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  var users = [];
  bool _loading = true;

  Future loadUsers() async {
    // user list link http://www.mocky.io/v2/5e4003663300006300b04cee
    http.Response response = await http.get('http://www.mocky.io/v2/5e4003663300006300b04cee');
    String content = response.body;
    List collection = json.decode(content);
    List<User> _users = collection.map((json) => User.fromJson(json)).toList();
    setState(() {
      users = _users;
      _loading = false;
    });
  }
  
  void initState() {
    loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CurvedScreen(
          child: Scaffold(
          appBar: AppBar(
            title: Text('Contacts'),
            leading: IconButton(icon: Icon(Icons.person), onPressed: () async {
              
            }),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.refresh), onPressed: () {
                
              }),
            ],
          ),
          body: Container(
            child: (_loading) ? Center(child: CircularProgressIndicator()) : ListView.separated(
              separatorBuilder: (context, index) => Divider(color: Colors.red, height: 5.0,),
              itemCount: users.length,
              itemBuilder: (BuildContext contains, int index) {
                User user = users[index];
                // print(message.isSelected);
                return UserTile(
                  user: user,
                );
              }
            ),
          )
        ),
    );
  }
}
