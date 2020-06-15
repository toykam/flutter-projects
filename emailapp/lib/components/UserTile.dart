import 'package:emailapp/models/UserModel.dart';
import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {

  UserTile({this.user});

  final User user;

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  // bool _isSelected = false;

  void _select () {
    // setState(() {
    //   // widget.message.isSele(widget.message.isSelected) ? false : true;
    //   _isSelected = (widget.message.isSelected) ? false : true;
    // });
  }

  TextStyle selectedTextStyle = TextStyle(
    color: Colors.brown,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  TextStyle emailTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  TextStyle emailSubTitleStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.user.name, style: emailTitleStyle,),
      subtitle: Text(widget.user.email, style: emailSubTitleStyle,),
      leading: CircleAvatar(
        child: Text(widget.user.name[0]),
      ),
      onLongPress: _select,
    );
  }
}
