import 'package:emailapp/components/CurveContainer.dart';
import 'package:emailapp/models/MessageModel.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ComposeNewMessage extends StatefulWidget {
  ComposeNewMessage({Key key}) : super(key: key);

  @override
  _ComposeNewMessageState createState() => _ComposeNewMessageState();
}

class _ComposeNewMessageState extends State<ComposeNewMessage> {
  String to = "";
  String subject = "";
  String body = "";
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Compose New Message"),
          elevation: 0,
        ),
        body: CurvedScreen(
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      onSaved: (value) => to = value,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'To Field Is Required!'),
                        EmailValidator(errorText: 'Enter a valid Email address'),
                      ]),
                      // validator: (value) => (value.length == 0) ? "Email field cannot be empty!" : value.contains('@') ? true : 'Provide a valid email',
                      decoration: InputDecoration(
                          labelText: 'To: ',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),ListTile(
                    title: TextFormField(
                      onSaved: (value) => subject = value,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Subject Field Is Required'),
                        MinLengthValidator(10, errorText: "Subject Must be more than 10"),
                      ]),
                      decoration: InputDecoration(
                          labelText: 'Subject: ',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  ListTile(
                    title:TextFormField(
                      maxLines: 8,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Message Body Field Is Required'),
                        MinLengthValidator(20, errorText: "Message Body Must be more than 20 characters"),
                      ]),
                      onSaved: (value) => body = value,
                      decoration: InputDecoration(
                        labelText: 'Body: ',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  ListTile(
                    title: RaisedButton(
                      onPressed: () {
                        // print(this.key.currentState.validate());
                        if (this.key.currentState.validate()) {
                          // print(body);
                          this.key.currentState.save();
                          Message message = Message(subject, body, false);
                          print(message);
                          Navigator.pop(context, message);
                        }
                      },
                      child: Text('Send'),
                    )
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
