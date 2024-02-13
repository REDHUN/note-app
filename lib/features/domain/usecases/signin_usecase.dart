import 'package:firebaseauthclean/features/data/respository/firebase_repoImpl.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class SingInUseCase {
  FirebaseRepo firebaseRepo = FirebaseRepoImpl();

  Future<void> signIn(String email, String password) {
    return firebaseRepo.signIn(email, password);
  }
}
