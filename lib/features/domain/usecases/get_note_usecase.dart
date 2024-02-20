import 'package:firebaseauthclean/features/data/respository/firebase_repoImpl.dart';
import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class GetNoteUseCase {
  FirebaseRepo firebaseRepo = FirebaseRepoImpl();
  Future<List<NoteEntity>> getNotes(String uid) {
    return firebaseRepo.getNotes(uid);
  }
}
