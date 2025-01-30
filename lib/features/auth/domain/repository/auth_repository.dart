import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> addStudent(AuthEntity authEntity);

  Future<Either<Failure, List<AuthEntity>>> getAllStudents();

  Future<Either<Failure, void>> deleteStudent(String d);

  Future<Either<Failure, String>> loginStudent(
      String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
