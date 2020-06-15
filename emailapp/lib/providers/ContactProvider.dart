import 'dart:async';

List<String> CONTACTS = ['User 1', 'User 2', 'User 3', 'User 4', 'User 5'];


class ContactProvider {

  Stream<List<String>> get contactListNow async* {
    yield CONTACTS.sublist(0, CONTACTS.length);
  }

  StreamController<int> _contactListController = StreamController<int>();

  Stream<int> get contactList => _contactListController.stream.asBroadcastStream();

  ContactProvider(){
    contactListNow.listen((list) => _contactListController.sink.add(list.length));
    contactListNow.listen((list) => list.forEach((data) => print(data.contains('1')))); 
  }

}