import 'package:app/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoData extends InheritedWidget {
  final List<Todo> todos;
  final Function() onTodoChanged;

  const TodoData({
    super.key,
    required super.child,
    required this.todos,
    required this.onTodoChanged,
  });
  static TodoData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TodoData>();

  }
  
  @override
  bool updateShouldNotify(covariant TodoData oldWidget) {
    return todos != oldWidget.todos;
  
  }

  
  
}
