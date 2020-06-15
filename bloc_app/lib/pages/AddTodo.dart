
import 'package:bloc_app/models/todo.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/notifiers/todo_notifier.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  bool isDone = false;
  String todoName = '';
  InputDecoration getInputDecoration({hint: ''}) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      labelText: hint,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenNotifier _screenNotifier = Provider.of<ScreenNotifier>(context);
    TodoNotifier _todoNotifier = Provider.of<TodoNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle('Add Todo'),
        actions: <Widget>[
          Text(_screenNotifier.getVisitedScreens.length.toString(), style: Theme.of(context).textTheme.display4,)
        ]
      ),
      body: PoppingPage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: getInputDecoration(hint: 'Input Todo Name'),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() => todoName = value);
                },
                // onSubmitted: (value) {
                //   if (value.length == 0) {
                //     Scaffold.of(context).showSnackBar(SnackBar(content: Text('This field is required!'), backgroundColor: Colors.red,));
                //   }
                // },
              )
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                child: Text('Done?', style: TextStyle(fontWeight: FontWeight.w900, color: (isDone == false) ? Colors.blue : Colors.red),),
                onTap: () {
                  setState(() => isDone = (isDone == false) ? true : false);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                child: Text('Add Todo'),
                onPressed: () {
                  print(todoName);
                  if (todoName.length == 0) {
                    print('Is empty');
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Todo name is required!'),));
                  } else {
                    // Todo newTodo = Todo(todoName, isDone);
                    // print(newTodo.title);
                    // _todoNotifier.addTodo(context, newTodo);
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}