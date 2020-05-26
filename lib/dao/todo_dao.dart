//データアクセスオブジェクト 
//TodoモデルのCRUDをする
//TodoRepositoryとDatabaseProviderの間
import 'dart:async';

import 'package:TodoApp/database/todo.database.dart';
import 'package:TodoApp/model/todo_model.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //ADD NEW TODO
  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = db.insert(todoTABLE, todo.toDatabaseJson());
    return result;
  }

  //GET ALL TODOS
  Future<List<Todo>> getTodos({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) result = await db.query(todoTABLE,     //QUERYがあればその分取ってくる。なければ全部
        columns: columns,
        where: 'description LIKE ?',
        whereArgs: ["%$query"]);
    } else {
      result = await db.query(todoTABLE, columns: columns);
    }

    List<Todo> todos = result.isNotEmpty                            //mapする
      ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
      : [];
    return todos;
  }

  //UPDATE
  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = await db.update(todoTABLE, todo.toDatabaseJson(),
      where: "id = ?", whereArgs: [todo.id]);         //idがtodo.idのデータを取ってくる
    return result;
  }

  //DELETE
  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(todoTABLE,
      where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //DELETE ALL TODOS
  Future deleteAllTodos() async {
    final db = await dbProvider.database;
    var result = await db.delete(todoTABLE,);
    return result;
  }
}