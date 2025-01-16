import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? image;

  // final String phone;
  // final BatchEntity batch;
  // final List<CourseEntity> courses;
  final String username;
  final String password;

  const StudentEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    // required this.phone,
    // required this.batch,
    // required this.courses,
    required this.username,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, fname, lname, image, username, password];
}
