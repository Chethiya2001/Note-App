import 'package:app/helpers/snackbar.dart';
import 'package:app/models/note_model.dart';
import 'package:app/services/note_service.dart';
import 'package:app/utils/layout_consts.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/text_theme.dart';
import 'package:app/widgets/note_catergory_card_widget.dart';
import 'package:flutter/material.dart';

class NotesByCatergory extends StatefulWidget {
  final String catergory;
  const NotesByCatergory({super.key, required this.catergory});

  @override
  State<NotesByCatergory> createState() => _NotesByCatergoryState();
}

class _NotesByCatergoryState extends State<NotesByCatergory> {
  final NoteService noteService = NoteService();
  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCatergory();
  }

  //load all notes by catergory
  Future<void> _loadNotesByCatergory() async {
    noteList = await noteService.getNotesByCatergory(widget.catergory);
    setState(() {
      print(noteList.length);
    });
  }

  //delete Note
  Future<void> _deleteNote(String noteId) async {
    try {
      await noteService.removeNote(noteId);
      if (mounted) {
        AppHelper.showShnackBar(context, "Deleted Note Successfully.");
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        AppHelper.showShnackBar(context, "Failed to delete Note.");
      }
    }
  }

  //edit Note
  void _editNote(Note note) {
    //navigate to edit note page
    RouterClass.router.push('/edit-note', extra: note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            //got to the notes page
            RouterClass.router.push('/notes');
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.catergory,
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 800,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppConstants.kDefaultPadding,
                    mainAxisSpacing: AppConstants.kDefaultPadding,
                    childAspectRatio: 7 / 11,
                  ),
                  itemCount: noteList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NoteCatergoryCard(
                      noteTitle: noteList[index].title,
                      noteContent: noteList[index].content,
                      //funtions
                      removeNote: () async {
                        _deleteNote(noteList[index].id);
                        setState(() {
                          noteList.removeAt(index);
                        });
                      },
                      editNote: () async {
                        _editNote(noteList[index]);
                      },
                      viewSingleNote: () {
                        RouterClass.router
                            .push('/single-note', extra: noteList[index]);
                      },
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
