import 'dart:async';


List messages = [
  {
    "subject": "First Message",
    "message": "This is my first message for you this year"
  },
  {
    "subject": "Second Message",
    "message": "This is my second message for you this year"
  },
  {
    "subject": "Val Message",
    "message": "This is my val message for you this year"
  }
];

class InboxProvider {

  Stream<List> get inboxList async* {
    for(var i = 0; i < messages.length; i++) {
      Future.delayed(Duration(seconds: 2));
      yield messages.sublist(0, i+1);
    }
  }

}