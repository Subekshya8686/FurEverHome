import 'dart:io';

import 'package:dio/dio.dart';
import 'package:furever_home/app/constants/api_endpoints.dart';
import 'package:furever_home/features/auth/data/data_source/auth_data_source.dart';
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
          // "lname": auth.lname,
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
          'profilePicture': await MultipartFile.fromFile(
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
