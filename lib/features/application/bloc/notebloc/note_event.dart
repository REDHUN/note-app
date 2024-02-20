// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class AddNoteEvent extends NoteEvent {
  final NoteEntity note;

  const AddNoteEvent({required this.note});
}

class GetNoteEvent extends NoteEvent {
  final String uid;
  const GetNoteEvent({
    required this.uid,
  });
}

class NoteLogoutEvent extends NoteEvent {}

class NoteDeleteEvent extends NoteEvent {
  final NoteEntity note;
  const NoteDeleteEvent({
    required this.note,
  });
}

class NoteUpdateEvent extends NoteEvent {
  final NoteEntity note;

  const NoteUpdateEvent({required this.note});
}
