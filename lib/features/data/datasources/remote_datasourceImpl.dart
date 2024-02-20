import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthclean/features/data/datasources/remote_datasource.dart';
import 'package:firebaseauthclean/features/data/models/note_model.dart';
import 'package:firebaseauthclean/features/domain/entities/note_entity.dart';
import 'package:firebaseauthclean/features/domain/entities/user_entities.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<String> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() async {
    User? user;
    user = FirebaseAuth.instance.currentUser;
    print(user);

    return user?.uid != null;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(), password: password.toString());
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    final userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email.toString(), password: user.password.toString());

    final users = userCredentials.user;
    if (users != null) {
      FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': user.name,
        'phone': user.phnumber,
      });
    } else {
      return;
    }
  }

  @override
  Future<void> addnote(NoteEntity note) async {
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(note.uid.toString())
        .set({
      'noteId': note.noteId,
      'note': note.note,
      'time': note.time,
      'uid': note.uid,
    });
  }

  @override
  Future<List<NoteEntity>> getNotes(String uid) async {
    // print('test');
    // return FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uid)
    //     .collection('notes')
    //     .snapshots()
    //     .map((querySnap) {
    //   return querySnap.docs.map((docSnap) {
    //     return NoteModel.fromSnapshot(docSnap);
    //   }).toList();
    // });

    List<NoteModel> NoteList = [];
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      final note = await FirebaseFirestore.instance.collection('notes').get();
      note.docs.forEach((element) {
        return NoteList.add(NoteModel.fromJson(element.data()));
      });
      return NoteList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteNote(NoteEntity noteEntity) async {
    try {
      await FirebaseFirestore.instance
          .collection("notes")
          .doc(noteEntity.uid)
          .delete()
          .then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    Map<String, dynamic> noteMap = Map();
    final noteCollectionRef =
        await FirebaseFirestore.instance.collection('notes');
    if (note.note != null) noteMap['note'] = note.note;
    if (note.time != null) noteMap['time'] = note.time;
    if (note.uid != null) noteMap['noteId'] = note.noteId;
    noteCollectionRef.doc(note.uid).update(noteMap);
  }
}
