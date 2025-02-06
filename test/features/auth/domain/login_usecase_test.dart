import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'token.mock.dart';

// Mock classes with mocktail
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository, MockTokenSharedPrefs());
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tToken = 'fake_token';

  final tLoginParams = LoginParams(email: tEmail, password: tPassword);

  group('LoginUseCase', () {
    test('should return Right(token) when the login is successful', () async {
      // Arrange
      when(() => mockAuthRepository.loginStudent(tEmail, tPassword))
          .thenAnswer((_) async => Right(tToken));

      // Act
      final result = await loginUseCase(tLoginParams);

      // Assert
      expect(result, Right(tToken));
      verify(() => mockAuthRepository.loginStudent(tEmail, tPassword))
          .called(1);
    });

    test('should return Left(failure) when login fails', () async {
      // Arrange
      final failure = Failure(
          message: "failed"); // Assuming ServerFailure is a subclass of Failure
      when(() => mockAuthRepository.loginStudent(tEmail, tPassword))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await loginUseCase(tLoginParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.loginStudent(tEmail, tPassword))
          .called(1);
    });
  });
}
