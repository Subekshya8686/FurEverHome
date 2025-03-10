import 'package:equatable/equatable.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String? fname;
  @HiveField(2)
  final String? lname;
  @HiveField(3)
  final String? image;

  // @HiveField(4)
  // final String dateOfBirth;
  // @HiveField(4)
  // final String? email;
  @HiveField(4)
  final String? email;
  @HiveField(5)
  final String? password;

  AuthHiveModel({
    String? studentId,
    this.fname,
    this.lname,
    this.image,
    this.email,
    this.password,
  }) : studentId = studentId ?? Uuid().v4();

  const AuthHiveModel.initial()
      : studentId = "",
        fname = "",
        lname = "",
        image = "",
        // dateOfBirth = "",
        // email = "",
        email = "",
        password = "";

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      studentId: entity.id,
      fname: entity.fname,
      lname: entity.lname,
      // dateOfBirth: entity.dateOfBirth,
      email: entity.email,
      // username: entity.username,
      password: entity.password,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      id: studentId,
      fname: fname,
      lname: lname,
      image: image,
      // dateOfBirth: dateOfBirth,
      // email: email,
      email: email,
      password: password,
    );
  }

  // TODO: implement props
  @override
  List<Object?> get props => [
        studentId,
        fname,
        lname,
        image,
        // dateOfBirth,
        email,
        // username,
        password,
      ];
}
