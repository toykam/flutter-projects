import 'package:emailapp/components/EmailTile.dart';
import 'package:emailapp/models/MessageModel.dart';
import 'package:emailapp/pages/MessageDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> _messages;
  List<Message> passedMessage;
  final SlidableController slidableController = SlidableController();

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    _messages = Message.browse();
    passedMessage = await _messages;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _messages,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              List<Message> messages = snapshot.data;
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.red,
                  height: 5.0,
                ),
                itemCount: messages.length,
                itemBuilder: (BuildContext contains, int index) {
                  Message message = messages[index];
                  // print(message.isSelected);
                  return Slidable(
                    controller: slidableController,
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Archive',
                        color: Colors.blue,
                        icon: Icons.archive,
                        closeOnTap: false,
                        onTap: () {},
                      ),
                      IconSlideAction(
                        caption: 'Share',
                        color: Colors.indigo,
                        icon: Icons.share,
                        closeOnTap: false,
                        onTap: () {},
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'More',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () {},
                        closeOnTap: false,
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                            messages.removeAt(index);
                            passedMessage = messages;
                          });
                        },
                      ),
                    ],
                    key: ObjectKey(message.toString()), 
                    child: EmailTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MesageDetail(message: message,)));
                      },
                      message: message,
                    )
                  );
                });
            }
            break;
        }
      }
    );
  }
}