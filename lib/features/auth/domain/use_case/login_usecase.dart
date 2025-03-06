import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.password,
    required this.email,
  });

  const LoginParams.initial()
      : email = "",
        password = "";

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.loginStudent(params.email, params.password);
  }
}
