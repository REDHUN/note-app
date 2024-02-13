import 'package:firebaseauthclean/features/domain/entities/user_entities.dart';

class UserModel extends UserEntity {
  const UserModel(
      {super.name, super.email, super.password, super.phnumber, super.uid});
}
