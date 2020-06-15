import 'package:emailapp/models/MessageModel.dart';
import 'package:emailapp/pages/ComposeNewMessage.dart';
import 'package:flutter/material.dart';

class ComposeButton extends StatelessWidget {
  const ComposeButton({Key key, this.messages}) : super(key: key);
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () async {
          Message message = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ComposeNewMessage()));
          if (message != null) {
            // messages.add(message);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Message sent successfully!'),
              backgroundColor: Colors.green,
            ));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
