import 'dart:io';

import 'package:furever_home/core/network/hive_service.dart';
import 'package:furever_home/features/auth/data/data_source/student_data_source.dart';
import 'package:furever_home/features/auth/data/model/student_hive_model.dart';
import 'package:furever_home/features/auth/domain/entity/student_entity.dart';

class StudentLocalDatasource implements IAuthDataSource {
  final HiveService _hiveService;

  StudentLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  // StudentLocalDatasource(this._hiveService);

  // register student
  @override
  Future<void> addStudent(StudentEntity studentEntity) async {
    try {
      final studentHiveModel = AuthHiveModel.fromEntity(studentEntity);
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
  Future<List<StudentEntity>> getAllStudents() {
    try {
      return _hiveService.getAllAuth().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<StudentEntity> getCurrentUser() {
    return Future.value(StudentEntity(
      id: '1',
      fname: "",
      lname: "",
      image: null,
      // batch: BatchEntity(batchName: ""),
      // courses: [],
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
