import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDatasource _authLocalDatasource;

  AuthLocalRepository({required AuthLocalDatasource authLocalDataSource})
      : _authLocalDatasource = authLocalDataSource;

  @override
  Future<Either<Failure, void>> addStudent(AuthEntity authEntity) {
    try {
      _authLocalDatasource.addStudent(authEntity);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String d) async {
    try {
      await _authLocalDatasource.deleteStudent(d);
      return Right(null);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: "Error Deleting Student: $e"),
      );
    }
  }

  @override
  Future<Either<Failure, List<AuthEntity>>> getAllStudents() async {
    try {
      final students = await _authLocalDatasource.getAllStudents();
      return Right(students);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: "error deleting student: $e"),
      );
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDatasource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginStudent(
      String username, String password) async {
    try {
      final token = await _authLocalDatasource.loginStudent(username, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserById(String userId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateStudentById(
      String userId, AuthEntity auth) {
    // TODO: implement updateStudentById
    throw UnimplementedError();
  }
}
