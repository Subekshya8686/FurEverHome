import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furever_home/app/shared_prefs/token_shared_prefs.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  // @override
  // Future<Either<Failure, String>> call(LoginParams params) {
  //   // return repository.loginStudent(params.email, params.password);
  //   return repository.loginStudent(params.email, params.password).then((value) {
  //     print(value);
  //     return value.fold(
  //           (failure) => Left(failure),
  //           (token) {
  //         tokenSharedPrefs.saveToken(token);
  //         tokenSharedPrefs.getToken().then((value) {
  //           print(value);
  //         });
  //         tokenSharedPrefs.saveUserId(token);
  //         tokenSharedPrefs.getUserId().then((value) {
  //           print(value);
  //         });
  //         return Right(token);
  //       },
  //     );
  //   });
  // }

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    // Call to the repository for login
    final loginResult =
        await repository.loginStudent(params.email, params.password);

    return loginResult.fold(
      (failure) => Left(failure), // If login failed, return the failure
      (token) async {
        // Extract userId from the token using JWT decoding
        String userId = _fetchUserIdFromToken(token);

        // Save both the token and userId to shared preferences
        await tokenSharedPrefs.saveToken(token);
        await tokenSharedPrefs.saveUserId(userId);

        // Optionally, fetch and print for debugging
        final storedToken = await tokenSharedPrefs.getToken();
        final storedUserId = await tokenSharedPrefs.getUserId();

        storedToken.fold(
          (failure) => print('Failed to retrieve token: ${failure.message}'),
          (token) => print('Stored token: $token'),
        );

        storedUserId.fold(
          (failure) => print('Failed to retrieve userId: ${failure.message}'),
          (userId) => print('Stored userId: $userId'),
        );

        // Return the token or any other relevant information
        return Right(token);
      },
    );
  }

  String _fetchUserIdFromToken(String token) {
    if (JwtDecoder.isExpired(token)) {
      throw Exception("Token is expired");
    }

    // Decode the JWT token and extract the userId
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['userId'] ??
        ''; // Replace 'userId' with the actual key in the token
  }
}
