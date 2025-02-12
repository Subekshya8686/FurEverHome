import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<void> addStudent(AuthEntity studentEntity);

  Future<List<AuthEntity>> getAllStudents();

  Future<void> deleteStudent(String d);

  Future<String> loginStudent(String username, String password);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getUserById(String userId);

  Future<Either<Failure, void>> updateStudentById(
      String userId, AuthEntity auth);
}
