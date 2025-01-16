import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/data/data_source/local_datasource/student_local_datasource.dart';
import 'package:furever_home/features/auth/domain/entity/student_entity.dart';
import 'package:furever_home/features/auth/domain/repository/student_repository.dart';

class StudentLocalRepository implements IAuthRepository {
  final StudentLocalDatasource _studentLocalDatasource;

  StudentLocalRepository(
      {required StudentLocalDatasource studentLocalDataSource})
      : _studentLocalDatasource = studentLocalDataSource;

  @override
  Future<Either<Failure, void>> addStudent(StudentEntity studentEntity) {
    try {
      _studentLocalDatasource.addStudent(studentEntity);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String d) async {
    try {
      await _studentLocalDatasource.deleteStudent(d);
      return Right(null);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: "Error Deleting Student: $e"),
      );
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getAllStudents() async {
    try {
      final students = await _studentLocalDatasource.getAllStudents();
      return Right(students);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: "error deleting student: $e"),
      );
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> getCurrentUser() async {
    try {
      final currentUser = await _studentLocalDatasource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginStudent(
      String username, String password) async {
    try {
      final token =
          await _studentLocalDatasource.loginStudent(username, password);
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
}
