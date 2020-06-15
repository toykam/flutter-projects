// import 'package:sqflite/sqflite.dart';

// class DBHelperL<T> {

//   Database db;

//   final String tableTodo = 'todo';
//   final String columnId = '_id';
//   final String columnTitle = 'title';
//   final String columnDone = 'done';

//   Future open(String path) async {
//     db = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute('''
//         create table $tableTodo ( 
//           $columnId integer primary key autoincrement, 
//           $columnTitle text not null,
//           $columnDone integer not null)
//         ''');
//     });
//   }

//   Future<T> insert(T todo) async {
//     print(todo.title);
//     todo.id = await db.insert(tableTodo, todo.toMap());
//     return todo;
//   }

//   Future<Todo> getTodo(int id) async {
//     List<Map> maps = await db.query(tableTodo,
//         columns: [columnId, columnDone, columnTitle],
//         where: '$columnId = ?',
//         whereArgs: [id]);
//     if (maps.length > 0) {
//       return Todo.fromMap(maps.first);
//     }
//     return null;
//   }

//   Future<List<Todo>> getAllTodo() async {
//     List<Todo> _todos = [];
//     List<Map> maps = await db.query(tableTodo);
//     if (maps.length > 0) {
//       maps.forEach((todo) {
//         _todos.add(Todo.fromMap(todo));
//       });
//       return _todos;
//     }
//     return null;
//   }

//   Future<int> delete(int id) async {
//     return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
//   }

//   Future<int> update(Todo todo) async {
//     return await db.update(tableTodo, todo.toMap(),
//         where: '$columnId = ?', whereArgs: [todo.id]);
//   }

//   Future close() async => db.close();
// }