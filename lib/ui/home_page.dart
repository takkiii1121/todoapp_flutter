
import 'package:TodoApp/bloc/todo_bloc.dart';
import 'package:TodoApp/model/todo_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final TodoBloc todoBloc = TodoBloc();
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: getTodosWidget(),
    );
  }

  Widget getTodosWidget() {
    return StreamBuilder(
      stream: todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        return getTodoCardWidget(snapshot);
      },
    );
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Todo>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
        ? ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, itemPosition) {
              Todo todo = snapshot.data[itemPosition];
              return Container(
                color: Colors.red,
                child: Text(
                  '${todo.id}',
                ),
              );
            }
        ) : Container(color: Colors.red,);
    } else {
      return Container(color: Colors.blue,);
    }
  }
}