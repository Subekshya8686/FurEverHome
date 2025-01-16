import 'package:equatable/equatable.dart';
import 'package:furever_home/features/auth/domain/entity/student_entity.dart';
import 'package:furever_home/features/batch/data/model/batch_hive_model.dart';
import 'package:furever_home/features/course/data/model/course_hive_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'student_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String fname;
  @HiveField(2)
  final String lname;
  @HiveField(3)
  final String? image;

  // @HiveField(4)
  // final BatchHiveModel batch;
  // @HiveField(6)
  // final List<CourseHiveModel> courses;
  @HiveField(4)
  final String username;
  @HiveField(5)
  final String password;

  AuthHiveModel({
    String? studentId,
    required this.fname,
    required this.lname,
    this.image,
    // required this.batch,
    // required this.courses,
    required this.username,
    required this.password,
  }) : studentId = studentId ?? Uuid().v4();

  const AuthHiveModel.initial()
      : studentId = "",
        fname = "",
        lname = "",
        image = "",
        // batch = const BatchHiveModel.initial(),
        // courses = const [],
        username = "",
        password = "";

  factory AuthHiveModel.fromEntity(StudentEntity entity) {
    return AuthHiveModel(
      studentId: entity.id,
      fname: entity.fname,
      lname: entity.lname,
      // batch: BatchHiveModel.fromEntity(entity.batch),
      // courses: CourseHiveModel.fromEntityList(entity.courses),
      username: entity.username,
      password: entity.password,
    );
  }

  StudentEntity toEntity() {
    return StudentEntity(
      id: studentId,
      fname: fname,
      lname: lname,
      image: image,
      // batch: batch.toEntity(),
      // courses: CourseHiveModel.toEntityList(courses),
      username: username,
      password: password,
    );
  }

  // TODO: implement props
  @override
  List<Object?> get props => [
        studentId,
        fname,
        lname,
        image,
        // batch,
        // courses,
        username,
        password,
      ];
}
