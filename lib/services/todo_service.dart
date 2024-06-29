import 'package:app/models/todo_model.dart';
import 'package:hive/hive.dart';

class TodoService {
  //all todos
  List<Todo> todos = [
    Todo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: true,
    ),
    Todo(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];
  //database refrence
  final _myBox = Hive.box('todos');

  //is user is new
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  //create initial todos
  Future<void> createInitialTodos() async {
    if (_myBox.isEmpty) {
      await _myBox.put("todos", todos);
    }
  }

  //load todos
  Future<List<Todo>> loadTodos() async {
    final dynamic todos = await _myBox.get("todos");
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<Todo>().toList();
    }
    return [];
  }

  //add todo
}
