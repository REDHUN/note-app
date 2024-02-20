import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthclean/features/application/bloc/notebloc/note_bloc.dart';
import 'package:firebaseauthclean/features/application/services/colors.dart';
import 'package:firebaseauthclean/features/application/view/home_view.dart';
import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uuid/uuid.dart';

class AddNotePageWrapper extends StatelessWidget {
  const AddNotePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(),
      child: const AddNotePage(),
    );
  }
}

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var uid = const Uuid().v1();
  @override
  void initState() {
    _noteTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  final TextEditingController _noteTextController = TextEditingController();
  final TextEditingController _titleTextController = TextEditingController();

  @override
  void dispose() {
    _noteTextController.dispose();
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteAddState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/home', (route) => false);
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.topToBottom,
                    child: HomePageWrapper()));
          });
        } else if (state is NoteAddingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            title: Text(
              "Note",
              style: GoogleFonts.aBeeZee(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.headingText),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${_noteTextController.text.length} Characters",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColor.textColor,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  controller: _titleTextController,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(color: AppColor.textColor)),
                ),
                Expanded(
                  child: Scrollbar(
                    child: TextFormField(
                      style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      controller: _noteTextController,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "start typing...",
                          hintStyle: TextStyle(color: AppColor.textColor)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<NoteBloc>(context).add(AddNoteEvent(
                        note: NoteEntity(
                            note: _noteTextController.text.trim(),
                            noteId: _titleTextController.text.trim(),
                            time: Timestamp.now(),
                            uid: uid)));
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.btnColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
