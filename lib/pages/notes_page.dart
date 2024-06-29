import 'package:app/models/note_model.dart';
import 'package:app/services/note_service.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/layout_consts.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/text_theme.dart';
import 'package:app/widgets/bottom_sheet_widget.dart';
import 'package:app/widgets/notesCard_widget.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> allNotes = [];
  final NoteService noteService = NoteService();
  Map<String, List<Note>> categorizedMap = {};
 
  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    // Check if the notes box is empty
    final bool isNewUser = await noteService.isNewUser();
    if (isNewUser) {
      // If the user is new, create the initial notes
      await noteService.createInitialNotes();
    }
    // Load the notes
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    final Map<String, List<Note>> categorizeMap =
        await noteService.categorizeMap(loadedNotes);

    setState(() {
      allNotes = loadedNotes;
      print(allNotes.length);
      categorizedMap = categorizeMap;
      print(categorizedMap);
    });
  }

  //open bottom sheet
  void _openBottomSheet() {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      builder: (context) {
        return CategoryInputBottomSheet(
          onNewCatergory: () {
            Navigator.of(context).pop();
            RouterClass.router.push('/create-note', extra: true);
          },
          onNewNote: () {
            Navigator.of(context).pop();
            RouterClass.router.push('/create-note', extra: false);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openBottomSheet,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(color: AppColors.kWhiteColor, width: 2),
        ),
        child: Icon(
          Icons.add,
          size: 30,
          color: AppColors.kWhiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notes",
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(
              height: AppConstants.kDefaultPadding,
            ),
            allNotes.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Center(
                      child: Text(
                        "No Notes Available , Please Add the the Notes.",
                        style: AppTextStyles.appDescription,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppConstants.kDefaultPadding,
                      mainAxisSpacing: AppConstants.kDefaultPadding,
                      childAspectRatio: 6 / 4,
                    ),
                    itemCount: categorizedMap.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //go to the notes by catergory
                          RouterClass.router.push('/catergory',
                              extra: categorizedMap.keys.elementAt(index));
                        },
                        child: NotesCard(
                          noteCatergories: categorizedMap.keys.elementAt(index),
                          numberOfNotes:
                              categorizedMap.values.elementAt(index).length,
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
