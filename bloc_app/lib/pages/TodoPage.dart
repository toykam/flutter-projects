import 'package:bloc_app/models/page_data.dart';
import 'package:bloc_app/models/todo.dart';
import 'package:bloc_app/notifiers/page_notifier.dart';
import 'package:bloc_app/notifiers/todo_notifier.dart';
import 'package:bloc_app/screen_providers/add_todo_screen_provider.dart';
import 'package:bloc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenNotifier _screenNotifier = Provider.of<ScreenNotifier>(context);
    TodoNotifier _todoProvider = Provider.of<TodoNotifier>(context);
    // print(await _todoProvider.getAllTodos);
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(_screenNotifier.getPage.page_title),
        actions: <Widget>[
          Text(_screenNotifier.getVisitedScreens.length.toString(), style: Theme.of(context).textTheme.display4,)
        ],
      ),
      body: PoppingPage(
        child: FutureBuilder(
          future: _todoProvider.getAllTodos,
          builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
            // print(snapshot.data);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.amberAccent,),
                );
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return Text('Todos Will fly here');
                } else if (snapshot.hasError) {
                  return Text('Error:=> '+snapshot.error.toString());
                } else {
                  return Text('Nothing Found!');
                }
                
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _screenNotifier.changeScreen(context, PageData(page_title: 'Add Todo', screen: AddTodoScreenProvider())),
      ),
    );
  }
}