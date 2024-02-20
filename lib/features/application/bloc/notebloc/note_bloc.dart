import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:firebaseauthclean/features/domain/usecases/add_note_usecase.dart';
import 'package:firebaseauthclean/features/domain/usecases/delete_note_usecase.dart';
import 'package:firebaseauthclean/features/domain/usecases/get_note_usecase.dart';
import 'package:firebaseauthclean/features/domain/usecases/signout_usecase.dart';
import 'package:firebaseauthclean/features/domain/usecases/update_note_usecase.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<AddNoteEvent>((event, emit) async {
      // emit(NoteAddingState());
      // await Future.delayed(Duration(seconds: 3));
      AddNoteUseCase().addNote(event.note);
      emit(NoteAddState());
    });

    on<GetNoteEvent>((event, emit) async {
      try {
        emit(NoteAddingState());
        await Future.delayed(Duration(seconds: 1));
        final List<NoteEntity> notes =
            await GetNoteUseCase().getNotes(event.uid);
        if (notes.isEmpty) {
          emit(NoteEmptyState());
        } else {
          emit(NoteLoadedState(notes: notes));
        }
        // await Future.delayed(Duration(seconds: 2));
      } catch (e) {
        print('error error ');
        print(e.toString());
      }
    });

    on<NoteLogoutEvent>((event, emit) async {
      await SingOutUseCase().signOut();
    });

    on<NoteDeleteEvent>((event, emit) async {
      try {
        await DeleteNoteUseCase().deleteNote(event.note);
        final List<NoteEntity> notes = await GetNoteUseCase().getNotes('1');
        if (notes.isEmpty) {
          emit(NoteEmptyState());
        } else {
          emit(NoteAddingState());
          //await Future.delayed(Duration(seconds: 3));
          // await AddNoteUseCase().addNote(event.note);
          emit(NoteLoadedState(notes: notes));
        }
        //Future.delayed(Duration(seconds: 3));
      } catch (e) {
        print(e.toString());
      }
    });
    on<NoteUpdateEvent>((event, emit) async {
      try {
        await UpdateNoteUseCase().updateNote(event.note);
        // final List<NoteEntity> notes = await GetNoteUseCase().getNotes('1');
        // emit(NoteAddingState());
        // emit(NoteLoadedState(notes: notes));
        emit(NoteUpdateState());
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
