import 'package:firebaseauthclean/features/data/datasources/remote_datasource.dart';
import 'package:firebaseauthclean/features/data/datasources/remote_datasourceImpl.dart';
import 'package:firebaseauthclean/features/domain/entities/user_entities.dart';
import 'package:firebaseauthclean/features/domain/respository/firebase_repo.dart';

class FirebaseRepoImpl implements FirebaseRepo {
  RemoteDataSource remoteDataSource = RemoteDataSourceImpl();
  @override
  Future<String> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() {
    return remoteDataSource.isAuthenticated();
  }

  @override
  Future<void> signIn(String email, String password) {
    return remoteDataSource.signIn(email, password);
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) {
    return remoteDataSource.signUp(user);
  }
}
