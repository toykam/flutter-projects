import 'package:emailapp/models/MessageModel.dart';
import 'package:flutter/material.dart';

class EmailTile extends StatefulWidget {

  EmailTile({this.message, this.onTap});

  final Message message;
  final Function onTap;

  @override
  _EmailTileState createState() => _EmailTileState();
}

class _EmailTileState extends State<EmailTile> {
  bool _isSelected = false;

  void _select () {
    setState(() {
      // widget.message.isSele(widget.message.isSelected) ? false : true;
      _isSelected = (widget.message.isSelected) ? false : true;
    });
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
      title: Text(widget.message.subject, style: _isSelected? selectedTextStyle : emailTitleStyle, maxLines: 1, overflow: TextOverflow.ellipsis,),
      subtitle: Text(widget.message.body, maxLines: 2, overflow: TextOverflow.fade, style: emailSubTitleStyle,),
      isThreeLine: true,
      selected: _isSelected,
      leading: CircleAvatar(
        child: _isSelected? GestureDetector(
          child: Icon(Icons.check_circle),
          onTap: _select,
        ) : Text('AJ'),
      ),
      dense: true,
      onLongPress: _select,
      onTap: () {
        if (_isSelected) {
          _select();
        } else {
          widget.onTap();
        }
      },
    );
  }
}
