import 'package:app/helpers/snackbar.dart';
import 'package:app/models/note_model.dart';
import 'package:app/services/note_service.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/layout_consts.dart';
import 'package:app/utils/routes.dart';
import 'package:app/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CreateNewNotePage extends StatefulWidget {
  final bool isNewCatergory;
  const CreateNewNotePage({super.key, required this.isNewCatergory});

  @override
  State<CreateNewNotePage> createState() => _CreateNewNotePageState();
}

class _CreateNewNotePageState extends State<CreateNewNotePage> {
  List<String> catergeries = [];
  final NoteService noteService = NoteService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCatergoryController =
      TextEditingController();
  String selectedCatergory = "";

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
    _loadCatergories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Note",
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
                    widget.isNewCatergory
                        ? Container(
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
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: AppColors.kWhiteColor
                                            .withOpacity(0.1),
                                        width: 2),
                                  ),
                                  border: InputBorder.none),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter catergory";
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.kWhiteColor,
                                  fontFamily: GoogleFonts.dmSans().fontFamily),
                              isExpanded: false,
                              hint: const Text("Catergory"),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: AppColors.kWhiteColor
                                            .withOpacity(0.1),
                                        width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: AppColors.kWhiteColor,
                                      width: 1,
                                    ),
                                  )),
                              items: catergeries.map((String catergory) {
                                return DropdownMenuItem<String>(
                                  alignment: Alignment.centerLeft,
                                  value: catergory,
                                  child: Text(catergory,
                                      style: AppTextStyles.appButton),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedCatergory = value!;
                                });
                              },
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
                            //save the notes
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteService.addNote(
                                  Note(
                                    id: const Uuid().v4(),
                                    title: _noteTitleController.text,
                                    content: _noteContentController.text,
                                    catergory: widget.isNewCatergory
                                        ? _noteCatergoryController.text
                                        : selectedCatergory,
                                    date: DateTime.now(),
                                  ),
                                );
                                AppHelper.showShnackBar(
                                  context,
                                  "Note saved successfully",
                                );

                                _noteTitleController.clear();
                                _noteContentController.clear();
                                RouterClass.router.push('/notes');
                              } catch (e) {
                                AppHelper.showShnackBar(
                                    context, "Faild to Save Note.");
                                print(e.toString());
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(
                              "Save Note",
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
