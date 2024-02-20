import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:firebaseauthclean/features/domain/entities/user_entities.dart';

abstract class RemoteDataSource {
  Future<bool> isAuthenticated();
  Future<void> signIn(String email, String password);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUser();
  Future<void> addnote(NoteEntity note);
  Future<List<NoteEntity>> getNotes(String uid);
  Future<void> deleteNote(NoteEntity note);
  Future<void> updateNote(NoteEntity note);
}
