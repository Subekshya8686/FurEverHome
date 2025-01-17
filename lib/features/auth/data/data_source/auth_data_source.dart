import 'dart:io';

import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<void> addStudent(AuthEntity studentEntity);

  Future<List<AuthEntity>> getAllStudents();

  Future<void> deleteStudent(String d);

  Future<String> loginStudent(String username, String password);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
