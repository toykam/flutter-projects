import 'package:bloc_app/notifiers/todo_notifier.dart';
import 'package:bloc_app/pages/TodoPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TodoNotifier(),
      child: TodoPage(),
    );
  }
}