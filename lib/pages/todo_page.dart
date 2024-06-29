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
        onPressed: () {},
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
          ),
          CompletedTab(
            completdTodos: completedTodos,
          ),
        ],
      ),
    );
  }
}
