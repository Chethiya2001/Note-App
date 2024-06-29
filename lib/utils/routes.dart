import 'package:app/models/note_model.dart';
import 'package:app/pages/create_new_note_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/notes_by_catergory_page.dart';
import 'package:app/pages/notes_page.dart';
import 'package:app/pages/single_note_page.dart';
import 'package:app/pages/todo_page.dart';
import 'package:app/pages/edit_note_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterClass {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      //Home
      GoRoute(
        path: "/",
        name: "home",
        builder: (context, state) => const HomePage(),
      ),
      //Notes
      GoRoute(
        path: "/notes",
        name: "notes",
        builder: (context, state) => const NotesPage(),
      ),
      //Todo
      GoRoute(
        path: "/todos",
        name: "todos",
        builder: (context, state) => const TodoPage(),
      ),
      //notes by catergory
      GoRoute(
        path: "/catergory",
        name: "catergory",
        builder: (context, state) {
          final String catergory = state.extra as String;
          return NotesByCatergory(catergory: catergory);
        },
      ),
      //create new note
      GoRoute(
        path: "/create-note",
        name: "create-note",
        builder: (context, state) {
          final isNewCatergory = state.extra as bool;
          return CreateNewNotePage(isNewCatergory: isNewCatergory);
        },
      ),
      //edit note
      GoRoute(
        path: "/edit-note",
        name: "edit-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return EditNotePage(
            note: note,
          );
        },
      ),
      //single note
      GoRoute(
        path: "/single-note",
        name: "single-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return SingleNotePage(
            note: note,
          );
        },
      ),
    ],
  );
}
