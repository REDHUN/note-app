import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String? noteId;
  final String? note;
  final String? uid;
  final Timestamp? time;

  const NoteEntity({this.noteId, this.note, this.uid, this.time});
  @override
  List<Object?> get props => [noteId, note, uid, time];
}
