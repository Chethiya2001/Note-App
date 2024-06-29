import 'package:app/models/note_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  List<Note> allNotes = [
    Note(
      id: const Uuid().v4(),
      title: "Meeting Notes",
      catergory: "Work",
      content:
          "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Grocery List",
      catergory: "Personal",
      content:
          "Bought milk, eggs, bread, fruits, and vegetables from the local grocery store. Also added some snacks for the week.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Book Recommendations",
      catergory: "Hobby",
      content:
          "Recently read 'Sapiens' by Yuval Noah Harari, which offered fascinating insights into the history of humankind. Also enjoyed 'Atomic Habits' by James Clear, a practical guide to building good habits and breaking bad ones.",
      date: DateTime.now(),
    ),
  ];
  // Create the database reference for notes
  final _myBox = Hive.box("notes");

  //check weather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // Method to create the initial notes if the box is empty
  Future<void> createInitialNotes() async {
    if (_myBox.isEmpty) {
      await _myBox.put("notes", allNotes);
    }
  }

  // Method to load the notes
  Future<List<Note>> loadNotes() async {
    final dynamic notes = await _myBox.get("notes");
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<Note>().toList();
    }
    return [];
  }

  //catergorize lis as map
  Map<String, List<Note>> categorizeMap(List<Note> allNotes) {
    final Map<String, List<Note>> categorizedMap = {};

    for (final note in allNotes) {
      if (categorizedMap.containsKey(note.catergory)) {
        categorizedMap[note.catergory]!.add(note);
      } else {
        categorizedMap[note.catergory] = [note];
      }
    }
    return categorizedMap;
  }

  //get notes using catergory
  Future<List<Note>> getNotesByCatergory(String catergory) async {
    final dynamic allNotes = await _myBox.get("notes");
    final List<Note> notes = [];

    for (final note in allNotes) {
      if (note.catergory == catergory) {
        notes.add(note);
      }
    }

    return notes;
  }

  //Edit note
  Future<void> updateNote(Note note) async {
    try {
      final dynamic allNotes = await _myBox.get("notes");
      final int index = allNotes.indexWhere((n) => n.id == note.id);
      allNotes[index] = note;
      await _myBox.put("notes", allNotes);
    } catch (e) {
      print(e.toString());
    }
  }

  //Remove note
  Future<void> removeNote(String noteId) async {
    try {
      final dynamic allNotes = await _myBox.get("notes");
      allNotes.removeWhere((n) => n.id == noteId);
      await _myBox.put("notes", allNotes);
    } catch (e) {
      print(e.toString());
    }
  }

  //load all catergories
  Future<List<String>> loadAllCatergories() async {
    final dynamic allNotes = await _myBox.get("notes");
    final List<String> catergories = [];
    for (final note in allNotes) {
      if (!catergories.contains(note.catergory)) {
        catergories.add(note.catergory);
      }
    }
    return catergories;
  }
  //add anew notes
  Future<void> addNote(Note note) async {
    try {
      final dynamic allNotes = await _myBox.get("notes");
      allNotes.add(note);
      await _myBox.put("notes", allNotes);
    } catch (e) {
      print(e.toString());
    }
  }	
}
