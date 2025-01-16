import 'package:dartz/dartz.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/student_entity.dart';
import 'package:furever_home/features/auth/domain/repository/student_repository.dart';

class GetAllStudentsUsecase
    implements UsecaseWithoutParams<List<StudentEntity>> {
  final IAuthRepository repository;

  GetAllStudentsUsecase(this.repository);

  @override
  Future<Either<Failure, List<StudentEntity>>> call() async {
    try {
      return await repository.getAllStudents();
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
}
