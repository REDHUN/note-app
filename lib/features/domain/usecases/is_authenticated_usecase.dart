import 'package:firebaseauthclean/features/data/respository/firebase_repoImpl.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class IsAuthenticateUseCase {
  FirebaseRepo firebaseRepo = FirebaseRepoImpl();

  Future<bool> isAuthenticated() {
    return firebaseRepo.isAuthenticated();
  }
}
