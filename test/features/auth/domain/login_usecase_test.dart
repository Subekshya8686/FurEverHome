import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/app/shared_prefs/token_shared_prefs.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    loginUseCase = LoginUseCase(mockAuthRepository, mockTokenSharedPrefs);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tToken = 'fake_token';
  const tUserId = 'user123'; // Mocked user ID

  final tLoginParams = LoginParams(email: tEmail, password: tPassword);

  group('LoginUseCase', () {
    test('should return Right(token) when login is successful', () async {
      // Arrange
      when(() => mockAuthRepository.loginStudent(tEmail, tPassword))
          .thenAnswer((_) async => Right(tToken));

      // Mock the methods returning Future<void>
      when(() => mockTokenSharedPrefs.saveToken(tToken))
          .thenAnswer((_) async => Future.value(null));
      when(() => mockTokenSharedPrefs.saveUserId(tUserId))
          .thenAnswer((_) async => Future.value(null));

      // Act
      final result = await loginUseCase(tLoginParams);

      // Assert
      expect(result, Right(tToken));
      verify(() => mockAuthRepository.loginStudent(tEmail, tPassword))
          .called(1);
      verify(() => mockTokenSharedPrefs.saveToken(tToken)).called(1);
      verify(() => mockTokenSharedPrefs.saveUserId(tUserId)).called(1);
    });

    test('should return Left(failure) when login fails', () async {
      // Arrange
      final failure = Failure(message: "failed");
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
