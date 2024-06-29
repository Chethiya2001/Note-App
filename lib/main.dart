import 'package:app/models/note_model.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/theme_dark.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  //adapters registration
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TodoAdapter());

  // Open Hive box
  await Hive.openBox('notes');
  await Hive.openBox('todos');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouterClass.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme.copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
