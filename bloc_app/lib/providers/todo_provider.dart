import 'package:bloc_app/models/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoProvider {
  Database db;
  final String tableTodo = 'todo';
  final String columnId = '_id';
  final String columnTitle = 'title';
  final String columnDone = 'done';

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), '$tableTodo.db'), version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''
        create table IF NOT EXISTS $tableTodo (
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDone integer not null)
        ''');
    });
  }

  Future<Todo> insert(Todo todo) async {
    // print(todo.title);
    await open();
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo> getTodo(int id) async {
    await open();
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Todo>> getAllTodo() async {
    await open();
    List<Todo> _todos = [];
    List<Map> maps = await db.query(tableTodo);
    if (maps.length > 0) {
      maps.forEach((todo) {
        _todos.add(Todo.fromMap(todo));
      });
      return _todos;
    }
    return null;
  }

  Future<int> delete(int id) async {
    await open();
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    await open();
    return await db.update(tableTodo, todo.toMap(),
      where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}