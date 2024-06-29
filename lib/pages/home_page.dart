
import 'package:app/utils/layout_consts.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/text_theme.dart';
import 'package:app/widgets/note_todo_card_widget.dart';
import 'package:app/widgets/progress_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const ProgressCardWidget(
              completedTask: 2,
              totalTasks: 5,
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
                  child: const NotesCardWidget(
                    title: 'Notes',
                    description: '3 Notes',
                    icon: Icons.bookmark_add_outlined,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    RouterClass.router.push('/todos');
                  },
                  child: const NotesCardWidget(
                    title: 'Todo List',
                    description: '5 Tasks',
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
            )
          ],
        ),
      ),
    );
  }
}
