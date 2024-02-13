import 'package:firebaseauthclean/features/data/respository/firebase_repoImpl.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class SingOutUseCase {
  FirebaseRepo firebaseRepo = FirebaseRepoImpl();

  Future<void> signOut() {
    return firebaseRepo.signOut();
  }
}
