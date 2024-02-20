import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthclean/features/application/bloc/notebloc/note_bloc.dart';
import 'package:firebaseauthclean/features/application/services/colors.dart';
import 'package:firebaseauthclean/features/application/view/home_view.dart';
import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateNotePageWrapper extends StatelessWidget {
  const UpdateNotePageWrapper({super.key, required this.note});
  final NoteEntity note;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(),
      child: UpdateNotePage(note: note),
    );
  }
}

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key, required this.note});
  final NoteEntity note;

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  TextEditingController? _noteTextController;
  TextEditingController? _titleTextController;
  @override
  void initState() {
    _noteTextController = TextEditingController(text: widget.note.note);
    _titleTextController = TextEditingController(text: widget.note.noteId);
    _titleTextController!.addListener(() {
      setState(() {});
    });
    _noteTextController!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _noteTextController!.dispose();
    _titleTextController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteUpdateState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePageWrapper()),
                (Route<dynamic> route) => false);
          });
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            title: const Text("Note"),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${_noteTextController?.text.length} Characters",
                  style: TextStyle(fontSize: 14, color: AppColor.textColor),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  controller: _titleTextController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Title"),
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
                    // BlocProvider.of<NoteBloc>(context).add(AddNoteEvent(
                    //     note: NoteEntity(
                    //         note: _noteTextController.text.trim(),
                    //         noteId: '2',
                    //         time: Timestamp.now(),
                    //         uid: uid)));
                    BlocProvider.of<NoteBloc>(context).add(NoteUpdateEvent(
                        note: NoteEntity(
                            note: _noteTextController?.text.trim(),
                            noteId: _titleTextController?.text.trim(),
                            uid: widget.note.uid,
                            time: Timestamp.now())));
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.btnColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      "Update",
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
