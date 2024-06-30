import 'package:app/models/todo_model.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;
  final bool isCompleted;
  final Function() onCheckBoxChecking;
  const TodoCard(
      {super.key,
      required this.todo,
      required this.isCompleted,
      required this.onCheckBoxChecking});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        title: Text(widget.todo.title, style: AppTextStyles.appDescription),
        subtitle: Row(
          children: [
            Text(
              "${widget.todo.date.day.toString()}/${widget.todo.date.month.toString()}/${widget.todo.date.year.toString()}",
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              width: 05,
            ),
            Text(
              "${widget.todo.time.hour.toString()}:${widget.todo.time.minute.toString()} ",
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted,
          onChanged: (value) => widget.onCheckBoxChecking(),
        ),
      ),
    );
  }
}
