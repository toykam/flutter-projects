import 'package:bloc_app/notifiers/todo_notifier.dart';
import 'package:bloc_app/pages/AddTodo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TodoNotifier(),
      child: AddTodoScreen(),
    );
  }
}