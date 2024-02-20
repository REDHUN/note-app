import 'package:firebaseauthclean/features/data/respository/firebase_repoImpl.dart';
import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class UpdateNoteUseCase {
  FirebaseRepo firebaseRepo = FirebaseRepoImpl();
  Future<void> updateNote(NoteEntity note) async {
    await firebaseRepo.updateNote(note);
  }
}
