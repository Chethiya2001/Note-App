import 'package:app/helpers/snackbar.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/services/todo_service.dart';
import 'package:app/utils/routes.dart';
import 'package:app/widgets/todo_card_widget.dart';
import 'package:app/widgets/todo_inherited_widget.dart';
import 'package:flutter/material.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completedTodos;
  final List<Todo> inCompletedTodos;
  const CompletedTab(
      {super.key,
      required this.completedTodos,
      required this.inCompletedTodos});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  final TodoService todoService = TodoService();
  //mark to do as done
  void _markTodoAsUnDone(Todo todo) async {
    try {
      final Todo updatedTod = Todo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: false,
      );

      await todoService.markAsDone(updatedTod);

      setState(() {
        widget.completedTodos.remove(todo);

        widget.inCompletedTodos.add(updatedTod);
      });

      AppHelper.showShnackBar(context, "Marked As UnDone");
      RouterClass.router.push('/todos');
    } catch (e) {
      print(e.toString());

      AppHelper.showShnackBar(context, "Failed To Mark As UnDone");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.completedTodos.sort((a, b) => a.time.compareTo(b.time));
    });
    return TodoData(
      todos: widget.completedTodos,
      onTodoChanged: () {},
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
                final Todo todo = widget.completedTodos[index];
                return TodoCard(
                  todo: todo,
                  isCompleted: false,
                  onCheckBoxChecking: () => _markTodoAsUnDone(todo),
                );
              },
              itemCount: widget.completedTodos.length,
            ))
          ],
        ),
      ),
    );
  }
}
