import 'package:app/helpers/snackbar.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/services/todo_service.dart';
import 'package:app/utils/routes.dart';
import 'package:app/widgets/todo_card_widget.dart';
import 'package:app/widgets/todo_inherited_widget.dart';
import 'package:flutter/material.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> inCompletedTodos;
  final List<Todo> completedTodos;
  const TodoTab(
      {super.key,
      required this.inCompletedTodos,
      required this.completedTodos});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  final TodoService todoService = TodoService();
  //mark to do as done
  void _markTodoAsDone(Todo todo) async {
    try {
      final Todo updatedTod = Todo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );
      await todoService.markAsDone(updatedTod);

      // ignore: use_build_context_synchronously
      AppHelper.showShnackBar(context, "Marked As Done");
      setState(() {
        widget.inCompletedTodos.remove(todo);
        widget.completedTodos.add(updatedTod);
      });
      RouterClass.router.push('/todos');
    } catch (e) {
      print(e.toString());

      AppHelper.showShnackBar(context, "Failed To Mark As Done");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.inCompletedTodos.sort((a, b) => a.time.compareTo(b.time));
    });
    return TodoData(
      onTodoChanged: () {},
      todos: widget.inCompletedTodos,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                final Todo todo = widget.inCompletedTodos[index];
                return Dismissible(
                  key: Key(
                    todo.id.toString(),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      widget.inCompletedTodos.removeAt(index);
                      TodoService().removeTodo(todo.id.toString());
                    });
                    AppHelper.showShnackBar(
                        context, "Deleted Note Successfully");
                  },
                  child: TodoCard(
                    todo: todo,
                    isCompleted: false,
                    onCheckBoxChecking: () => _markTodoAsDone(todo),
                  ),
                );
              },
              itemCount: widget.inCompletedTodos.length,
            ))
          ],
        ),
      ),
    );
  }
}
