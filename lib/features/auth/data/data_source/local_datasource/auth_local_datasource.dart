import 'dart:io';

import 'package:furever_home/core/network/hive_service.dart';
import 'package:furever_home/features/auth/data/data_source/auth_data_source.dart';
import 'package:furever_home/features/auth/data/model/auth_hive_model.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDatasource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  // StudentLocalDatasource(this._hiveService);

  // register student
  @override
  Future<void> addStudent(AuthEntity authEntity) async {
    try {
      final studentHiveModel = AuthHiveModel.fromEntity(authEntity);
      await _hiveService.addAuth(studentHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteStudent(String d) async {
    try {
      return await _hiveService.deleteAuth(d.toString());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<AuthEntity>> getAllStudents() {
    try {
      return _hiveService.getAllAuth().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    return Future.value(AuthEntity(
      id: '1',
      fname: "",
      lname: "",
      dateOfBirth: "",
      email: "",
      image: null,
      username: "",
      password: "",
    ));
  }

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      await _hiveService.loginStudent(username, password);
      return Future.value('Success');
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
