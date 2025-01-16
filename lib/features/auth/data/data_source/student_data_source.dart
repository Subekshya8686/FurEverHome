import 'dart:io';

import 'package:furever_home/features/auth/domain/entity/student_entity.dart';

abstract interface class IAuthDataSource {
  Future<void> addStudent(StudentEntity studentEntity);

  Future<List<StudentEntity>> getAllStudents();

  Future<void> deleteStudent(String d);

  Future<String> loginStudent(String username, String password);

  Future<StudentEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
