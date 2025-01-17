import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';

class CreateStudentParams extends Equatable {
  final String fname;
  final String lname;
  final String username;
  final String password;
  final String dateOfBirth;
  final String email;

  // final BatchEntity batch;
  // final List<CourseEntity> courses;

  const CreateStudentParams({
    required this.fname,
    required this.lname,
    required this.username,
    required this.password,
    required this.dateOfBirth,
    required this.email,
    // required this.courses,
  });

  @override
  List<Object?> get props =>
      [fname, lname, email, dateOfBirth, username, password];
}

class CreateStudentUsecase
    implements UsecaseWithParams<void, CreateStudentParams> {
  final IAuthRepository repository;

  CreateStudentUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateStudentParams params) async {
    try {
      // Create a StudentEntity object from the params
      final student = AuthEntity(
        fname: params.fname,
        lname: params.lname,
        username: params.username,
        password: params.password,
        dateOfBirth: params.dateOfBirth,
        email: params.email,
        // courses: params.courses,
      );

      // Call the repository to create the student
      return await repository.addStudent(student);
    } catch (error) {
      // Handle exceptions and return a Failure
      return Left(Failure(message: error.toString()));
    }
  }
}
