import 'package:app/models/note_model.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/services/note_service.dart';
import 'package:app/services/todo_service.dart';
import 'package:app/utils/layout_consts.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/text_theme.dart';
import 'package:app/widgets/main_screen_todo_card.dart';
import 'package:app/widgets/note_todo_card_widget.dart';
import 'package:app/widgets/progress_card_widget.dart';
import 'package:app/widgets/todo_inherited_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> allNotes = [];
  List<Todo> allTodos = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _checkUserIsNew();
    });
  }

  void _checkUserIsNew() async {
    final bool isNewUser =
        await NoteService().isNewUser() || await TodoService().isNewUser();
    if (isNewUser) {
      await NoteService().createInitialNotes();
      await TodoService().createInitialTodos();
    }
    _loadNotes();
    _loadTodos();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await NoteService().loadNotes();
    setState(() {
      allNotes = loadedNotes;
    });
  }

  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await TodoService().loadTodos();
    setState(() {
      allTodos = loadedTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TodoData(
      onTodoChanged: _loadTodos,
      todos: allTodos,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "NoteSphere",
            style: AppTextStyles.appTitle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: AppConstants.kDefaultPadding * 1.5,
              ),
              ProgressCardWidget(
                completedTask: allTodos
                    .where(
                      (element) => element.isDone,
                    )
                    .length,
                totalTasks: allTodos.length,
              ),
              const SizedBox(
                height: AppConstants.kDefaultPadding,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      RouterClass.router.push('/notes');
                    },
                    child: NotesCardWidget(
                      title: 'Notes',
                      description: '${allNotes.length.toString()} Notes',
                      icon: Icons.bookmark_add_outlined,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      RouterClass.router.push('/todos');
                    },
                    child: NotesCardWidget(
                      title: 'Todo List',
                      description: '${allTodos.length.toString()} Tasks',
                      icon: Icons.today_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppConstants.kDefaultPadding * 1.5,
              ),
              const Row(
                children: [
                  Text(
                    "Today's Progress",
                    style: AppTextStyles.appSubtitle,
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: AppTextStyles.appButton,
                  )
                ],
              ),
              const SizedBox(
                height: AppConstants.kDefaultPadding,
              ),
              allTodos.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "No tasks for today , Add some tasks to get started!",
                              style: AppTextStyles.appDescription.copyWith(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                RouterClass.router.push("/todos");
                              },
                              child: const Text("Add Task"),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: allTodos.length,
                        itemBuilder: (context, index) {
                          final Todo todo = allTodos[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: MainScreenTodo(
                              title: todo.title,
                              time: todo.time.toString(),
                              date: todo.date.toString(),
                              isDone: todo.isDone,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
