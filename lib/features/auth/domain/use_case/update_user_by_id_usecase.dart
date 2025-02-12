import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';

class UpdateStudentByIdUseCase {
  final IAuthRepository repository;

  UpdateStudentByIdUseCase(this.repository);

  Future<Either<Failure, void>> call(String userId, AuthEntity auth) async {
    return await repository.updateStudentById(userId, auth);
  }
}
