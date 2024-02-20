import 'package:firebaseauthclean/features/data/respository/firebase_repoImpl.dart';
import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class DeleteNoteUseCase {
  FirebaseRepo firebaseRepo = FirebaseRepoImpl();
  Future<void> deleteNote(NoteEntity note) async {
    await firebaseRepo.deleteNote(note);
  }
}
