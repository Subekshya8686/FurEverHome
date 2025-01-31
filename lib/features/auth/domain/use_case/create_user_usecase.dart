import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';

class CreateStudentParams extends Equatable {
  final String fname;
  final String lname;

  // final String username;
  final String email;
  final String password;
  final String? image;
  final String? phone;

  // final String dateOfBirth;

  // final BatchEntity batch;
  // final List<CourseEntity> courses;

  const CreateStudentParams({
    required this.fname,
    required this.lname,
    // required this.username,
    required this.password,
    // required this.dateOfBirth,
    required this.phone,
    required this.email,
    this.image,
    // required this.courses,
  });

  @override
  List<Object?> get props => [fname, lname, email, password];
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
        email: params.email,
        phone: params.phone,
        password: params.password,
        image: params.image,
        // dateOfBirth: params.dateOfBirth,
        // email: params.email,
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
