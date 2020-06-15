
import 'package:emailapp/models/MessageModel.dart';
import 'package:emailapp/pages/ComposeNewMessage.dart';
import 'package:flutter/material.dart';

// import '';

class SideBarDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Kabir Toyyib'),
              accountEmail: Text('kabirtoyyib19@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://instagram.flos8-1.fna.fbcdn.net/v/t51.2885-19/s150x150/72612532_2493125267407932_4129307147513102336_n.jpg?_nc_ht=instagram.flos8-1.fna.fbcdn.net&_nc_ohc=OJMnL8KYDQkAX9iZT6h&oh=2b832e29cac7755894398e825402c0cf&oe=5EDCEB6E'),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context) => AlertDialog(title: Text('Creating new account...')));
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 20.0)),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Compose Mesage'),
              onTap: () async { 
                Message message = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ComposeNewMessage()));
                if (message != null) {
                  print(message);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Inbox'),
              trailing: Chip(label: Text('10')),
            ),
            ListTile(
              leading: Icon(Icons.drafts),
              title: Text('Draft'),
              trailing: Chip(label: Text('5')),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('Archive'),
              trailing: Chip(label: Text('17')),
            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text('Sent'),
              trailing: Chip(label: Text('2')),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Trash'),
              trailing: Chip(label: Text('6')),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child:  ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              )
            )
          ],
        )
      ),
    );
  }
}