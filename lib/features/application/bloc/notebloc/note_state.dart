part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteAddingState extends NoteAddState {}

class NoteAddState extends NoteState {}

class NoteLoadedState extends NoteState {
  final List<NoteEntity> notes;

  const NoteLoadedState({required this.notes});
}

class NoteEmptyState extends NoteState {}

class NoteUpdateState extends NoteState {}
