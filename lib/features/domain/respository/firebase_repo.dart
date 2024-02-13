import 'package:firebaseauthclean/features/domain/entities/user_entities.dart';

abstract class FirebaseRepo {
  Future<bool> isAuthenticated();
  Future<void> signIn(String email, String password);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUser();
}
