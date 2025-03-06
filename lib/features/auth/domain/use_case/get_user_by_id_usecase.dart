import 'package:dartz/dartz.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';

class GetUserByIdUseCase implements UsecaseWithParams<AuthEntity, String> {
  final IAuthRepository repository;

  GetUserByIdUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(String id) async {
    print("usecase");
    return await repository.getUserById(id);
  }
}
