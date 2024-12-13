// ignore_for_file: non_constant_identifier_names

import 'package:idp/domain/entities/user.dart';

class UserModel {
  final String uuid;
  final String first_name;
  final String last_name;

  UserModel(
      {required this.uuid, required this.first_name, required this.last_name});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uuid: map['uuid'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(uuid: uuid, first_name: first_name, last_name: last_name);
  }
}
