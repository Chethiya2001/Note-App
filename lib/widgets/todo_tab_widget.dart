import 'package:app/models/todo_model.dart';
import 'package:app/widgets/todo_card_widget.dart';
import 'package:flutter/material.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> inCompletedTodos;
  const TodoTab({super.key, required this.inCompletedTodos});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              return TodoCard(
                todo: todo,
                isCompleted: false,
              );
            },
            itemCount: widget.inCompletedTodos.length,
          ))
        ],
      ),
    );
  }
}
