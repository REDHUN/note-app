import 'package:firebaseauthclean/features/data/respository/firebase_repoImpl.dart';
import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class AddNoteUseCase {
  FirebaseRepo firebaseRepo = FirebaseRepoImpl();
  Future<void> addNote(NoteEntity note) async {
    await firebaseRepo.addNote(note);
  }
}
