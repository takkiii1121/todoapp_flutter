import 'dart:async';

import 'package:TodoApp/model/todo_model.dart';
import 'package:TodoApp/repository/todo_repository.dart';

class TodoBloc {
  //リポジトリのインスタンスを取得
  final _todoRepository = TodoRepository();
  //todoのstreamを作成　todoRepositoryから非同期に非同期にデータを取得
  final _todoController = StreamController<List<Todo>>.broadcast();
  get todos => _todoController.stream;

  TodoBloc() {
    getTodos();
  }

  getTodos({String query}) async {
    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodos();
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodos();
  }

  deleteTodoById(int id) async {
    _todoRepository.deleteTodoById(id);
    getTodos();
  }

  dispose() {
    _todoController.close();
  }
}