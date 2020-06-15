import 'dart:async';

import 'package:bloc_app/models/todo.dart';
import 'package:bloc_app/providers/todo_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoNotifier extends ChangeNotifier {

  TodoProvider _todoProvider;

  Future<List<Todo>> get getAllTodos async => await _todoProvider.getAllTodo();


  addTodo(BuildContext context, Todo todo) async {
    Todo tod = await _todoProvider.insert(todo);
    if (tod != null) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Todo Added Successfully!'), backgroundColor: Colors.redAccent,));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Todo Not Added Successfully!'), backgroundColor: Colors.greenAccent,));
    }
  }


  TodoNotifier() {
    _todoProvider = TodoProvider();
    _todoProvider.open();
  }

}