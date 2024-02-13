import 'package:firebaseauthclean/features/data/respository/firebase_repoImpl.dart';
import 'package:firebaseauthclean/features/domain/entities/user_entities.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class SignUpUseCase {
  FirebaseRepo firebaseRepo = FirebaseRepoImpl();

  Future<void> signUp(UserEntity user) {
    return firebaseRepo.signUp(user);
  }
}
