import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthclean/features/data/datasources/remote_datasource.dart';
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
}
