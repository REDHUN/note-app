import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel({super.noteId, super.note, super.uid, super.time});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        note: json['note'],
        noteId: json['noteId'],
        time: json['time'],
        uid: json['uid']);
  }
}
