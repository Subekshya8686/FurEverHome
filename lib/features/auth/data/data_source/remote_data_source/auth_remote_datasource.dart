import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:furever_home/app/constants/api_endpoints.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/data/data_source/auth_data_source.dart';
import 'package:furever_home/features/auth/data/model/auth_api_model.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  @override
  Future<void> addStudent(AuthEntity auth) async {
    try {
      String fullName = '${auth.fname} ${auth.lname}';
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "name": fullName,
          "phone": auth.phone,
          "image": auth.image,
          "email": auth.email,
          "password": auth.password,
        },
      );
      print(response);
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserById(String userId) async {
    try {
      // Make the API request
      Response response = await _dio.get('${ApiEndpoints.register}/$userId');
      print("response: $response");
      print(response.statusCode);
      print(response.data);

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // If successful, convert the response data to an AuthEntity
        AuthApiModel authApiModel = AuthApiModel.fromJson(response.data);
        print(authApiModel);

        // Convert to AuthEntity
        AuthEntity authEntity = authApiModel.toEntity();
        print("auth entity: $authEntity");

        return Right(authEntity); // Return the entity wrapped in Right
      } else {
        // If the status code is not 200, return a failure
        return Left(ApiFailure(
            message:
                'Failed to fetch user with ID $userId: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      return Left(ApiFailure(message: 'DioError: ${e.message}'));
    } catch (e) {
      // Handle any other errors
      return Left(ApiFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateStudentById(
      String userId, AuthEntity auth) async {
    print("auth");
    try {
      String fullName = '${auth.fname} ${auth.lname}';
      Response response = await _dio.put(
        '${ApiEndpoints.update}/$userId',
        data: {
          "name": fullName,
          "phone": auth.phone,
          "image": auth.image,
          "email": auth.email,
        },
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ApiFailure(
            message:
                'Failed to update user with ID $userId: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(message: 'DioError: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<void> deleteStudent(String d) {
    // TODO: implement deleteStudent
    throw UnimplementedError();
  }

  @override
  Future<List<AuthEntity>> getAllStudents() {
    // TODO: implement getAllStudents
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginStudent(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      print('response: $response');
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
