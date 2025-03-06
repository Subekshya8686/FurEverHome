import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRemoteRepository(this._authRemoteDatasource);

  @override
  Future<Either<Failure, void>> addStudent(AuthEntity auth) async {
    try {
      await _authRemoteDatasource.addStudent(auth);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateStudentById(
      String userId, AuthEntity auth) async {
    try {
      await _authRemoteDatasource.updateStudentById(
          userId, auth); // Calls the data source method
      return Right(null); // Success (void indicates no return data)
    } catch (e) {
      return Left(ApiFailure(
          message: e.toString())); // If an error occurs, return a failure
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String d) {
    // TODO: implement deleteStudent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AuthEntity>>> getAllStudents() {
    // TODO: implement getAllStudents
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserById(String userId) async {
    try {
      // Fetch user data from the remote data source
      final result = await _authRemoteDatasource.getUserById(userId);
      print("result repo $result");

      return result; // Return the result (Either<Failure, AuthEntity>)
    } catch (e) {
      // If an error occurs, return a Failure
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginStudent(
      String email, String password) async {
    try {
      final token = await _authRemoteDatasource.loginStudent(email, password);
      return Right(token);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
