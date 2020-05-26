import 'package:TodoApp/dao/todo_dao.dart';
import 'package:TodoApp/model/todo_model.dart';

class TodoRepository {     //TodoDaoメソッドを呼び出す。関数ごとにTodoDaoを呼び出すことでUXがよくなる
  final todoDao = TodoDao();

  Future getAllTodos({String query}) => todoDao.getTodos(query: query);

  Future insertTodo(Todo todo) => todoDao.createTodo(todo);

  Future updateTodo(Todo todo) => todoDao.updateTodo(todo);

  Future deleteTodoById(int id) => todoDao.deleteTodo(id);

  Future deleteAllTodos() => todoDao.deleteAllTodos();
}