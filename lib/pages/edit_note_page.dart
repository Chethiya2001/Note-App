import 'package:app/helpers/snackbar.dart';
import 'package:app/models/note_model.dart';
import 'package:app/services/note_service.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/layout_consts.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EditNotePage extends StatefulWidget {
  final Note note;
  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  List<String> catergeries = [];
  final NoteService noteService = NoteService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCatergoryController =
      TextEditingController();

  @override
  void dispose() {
    _noteCatergoryController.dispose();
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  Future _loadCatergories() async {
    catergeries = await noteService.loadAllCatergories();
    setState(() {
      print(catergeries.length);
    });
  }

  @override
  void initState() {
    super.initState();
    //display already having data
    _noteTitleController.text = widget.note.title;
    _noteContentController.text = widget.note.content;
    _noteCatergoryController.text = widget.note.catergory;
    _loadCatergories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Note",
          style: AppTextStyles.appTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.kDefaultPadding / 2),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //dropdown

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _noteCatergoryController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter catergory";
                          }
                          return null;
                        },
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kWhiteColor,
                            fontFamily: GoogleFonts.dmSans().fontFamily),
                        decoration: InputDecoration(
                            hintText: "New Catergory",
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: AppColors.kWhiteColor.withOpacity(0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.kWhiteColor.withOpacity(0.1),
                                  width: 2),
                            ),
                            border: InputBorder.none),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    //title
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _noteTitleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter title";
                          }
                          return null;
                        },
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kWhiteColor,
                            fontFamily: GoogleFonts.dmSans().fontFamily),
                        decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                              fontSize: 30,
                              color: AppColors.kWhiteColor.withOpacity(0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.kWhiteColor.withOpacity(0.1),
                                  width: 2),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //title
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _noteContentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter content";
                          }
                          return null;
                        },
                        maxLines: 12,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kWhiteColor,
                            fontFamily: GoogleFonts.dmSans().fontFamily),
                        decoration: InputDecoration(
                            hintText: "Content",
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: AppColors.kWhiteColor.withOpacity(0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.kWhiteColor.withOpacity(0.1),
                                  width: 2),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                            AppColors.kFabColor,
                          )),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteService.updateNote(
                                  Note(
                                    title: _noteTitleController.text,
                                    catergory: _noteCatergoryController.text,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: widget.note.id,
                                  ),
                                );
                                AppHelper.showShnackBar(
                                    context, "Note Updated Successfully.");
                                //clear the text fields
                                _noteTitleController.clear();
                                _noteCatergoryController.clear();
                                _noteContentController.clear();
                                RouterClass.router.push('/notes');
                              } catch (e) {
                                print(e.toString());
                                AppHelper.showShnackBar(
                                    context, "Note Updated Faild.");
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(
                              "Update Note",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
