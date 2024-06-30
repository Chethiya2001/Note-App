import 'dart:ffi';

import 'package:app/helpers/snackbar.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/services/todo_service.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/text_theme.dart';
import 'package:app/widgets/completed_todo_tba_widget.dart';
import 'package:app/widgets/todo_tab_widget.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;
  TodoService todoService = TodoService();
  late List<Todo> todos = [];
  late List<Todo> incompleedTodos = [];
  late List<Todo> completedTodos = [];
  TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    tabBarController.dispose();
    taskController.dispose();
  }

  @override
  void initState() {
    super.initState();

    tabBarController = TabController(length: 2, vsync: this);
    _checkUserIsNew();
  }

  void _checkUserIsNew() async {
    final bool isNewUser = await todoService.isNewUser();

    if (isNewUser) {
      await todoService.createInitialTodos();
      _loadTodos();
    }
  }

  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await todoService.loadTodos();
    setState(() {
      todos = loadedTodos;
      print(todos.length);
      //incompleted todos
      incompleedTodos = todos.where((todo) => !todo.isDone).toList();
      //completed todos
      completedTodos = todos.where((todo) => todo.isDone).toList();
    });
  }

  //method for save tasks
  void _addTodo() async {
    try {
      if (taskController.text.isNotEmpty) {
        final Todo newTodo = Todo(
          title: taskController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );
        await todoService.addTodo(newTodo);
        setState(() {
          todos.add(newTodo);
          incompleedTodos.add(newTodo);
        });
        AppHelper.showShnackBar(context, "Task Added Successfully");
      }
    } catch (e) {
      AppHelper.showShnackBar(context, "Failed To Add Task");
    }
  }

  void openMessageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          contentPadding: EdgeInsets.zero,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Add Task",
                  style: AppTextStyles.appDescription
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: taskController,
                style: TextStyle(color: AppColors.kWhiteColor, fontSize: 20),
                decoration: InputDecoration(
                  hintText: "Enter Task",
                  hintStyle: AppTextStyles.appDescriptionSmall,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTodo();
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  AppColors.kCardColor,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text(
                "Add",
                style: AppTextStyles.appButton,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  AppColors.kCardColor,
                ),
              ),
              child: const Text(
                "Cancel",
                style: AppTextStyles.appButton,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: const [
            Tab(
              child: Text(
                'Todo',
                style: AppTextStyles.appDescription,
              ),
            ),
            Tab(
              child: Text(
                'Completed',
                style: AppTextStyles.appDescription,
              ),
            ),
          ],
          controller: tabBarController,
          dividerColor: Colors.transparent,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMessageModel(context);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 25,
        ),
      ),
      body: TabBarView(
        controller: tabBarController,
        children: [
          TodoTab(
            inCompletedTodos: incompleedTodos,
            completedTodos: completedTodos,
          ),
          CompletedTab(
            completedTodos: completedTodos,
            inCompletedTodos: incompleedTodos,
          ),
        ],
      ),
    );
  }
}
