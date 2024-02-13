import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity(
      {this.email, this.name, this.password, this.phnumber, this.uid});

  final String? name;
  final String? email;
  final String? password;
  final String? phnumber;
  final String? uid;

  @override
  List<Object?> get props => [name, email, password, phnumber, uid];
}
