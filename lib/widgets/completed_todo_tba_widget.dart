import 'package:app/models/todo_model.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completdTodos;
  const CompletedTab({super.key, required this.completdTodos});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Completed tab',
        style: AppTextStyles.appBody,
      ),
    );
  }
}
