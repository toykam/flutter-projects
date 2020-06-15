import 'package:emailapp/components/CurveContainer.dart';
import 'package:emailapp/components/SideBarDrawer.dart';
import 'package:emailapp/providers/ContactProvider.dart';
import 'package:flutter/material.dart';


class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactProvider contactProvider = ContactProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        elevation: 0,
        actions: <Widget>[
          StreamBuilder<int>(
            stream: contactProvider.contactList,
            builder: (context, snapshot) {
              return CircleAvatar(
                child: Text((snapshot.data ?? 0).toString()),
              );
            }
          ),
          Padding(padding: const EdgeInsets.only(right: 16),)
        ],
      ),
      drawer: SideBarDrawer(),
      body: CurvedScreen(
        child: Container(
          child: StreamBuilder<List<String>>(
            stream: contactProvider.contactListNow,
            builder: (context, snapshot) {
              print(snapshot);
              List<String> contacts = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(contacts[index]),
                    );
                }, separatorBuilder: (context, index) => Divider(), 
                itemCount: (snapshot.hasData) ? contacts.length : 0
              );
            }
          ),
        ),
      )
    );
  }
}