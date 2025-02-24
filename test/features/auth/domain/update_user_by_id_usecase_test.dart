import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/update_user_by_id_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mocking the repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UpdateStudentByIdUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  const tAuthEntity = AuthEntity(
    id: '1',
    fname: 'John',
    lname: 'Doe',
    image: 'https://example.com/image.jpg',
    email: 'john.doe@example.com',
    password: 'securePassword123',
    phone: '1234567890',
  );
  const tUserId = '1';

  // Register a fallback value for AuthEntity
  setUpAll(() {
    registerFallbackValue(tAuthEntity);
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UpdateStudentByIdUseCase(mockAuthRepository);
  });

  group('UpdateStudentByIdUseCase', () {
    test('should return void when the repository call is successful', () async {
      // Arrange
      when(() => mockAuthRepository.updateStudentById(any(), any())).thenAnswer(
          (_) async => const Right<Failure, void>(
              null)); // Corrected Right type with two type parameters

      // Act
      final result = await usecase(tUserId, tAuthEntity);

      // Assert
      expect(result,
          const Right<Failure, void>(null)); // Assert with the correct type
      verify(() => mockAuthRepository.updateStudentById(tUserId, tAuthEntity))
          .called(1);
    });

    test('should return a failure when the repository call fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Failed to update user');
      when(() => mockAuthRepository.updateStudentById(any(), any()))
          .thenAnswer((_) async => Left(failure)); // Simulate a failure

      // Act
      final result = await usecase(tUserId, tAuthEntity);

      // Assert
      expect(result, Left(failure)); // Expect the failure case
      verify(() => mockAuthRepository.updateStudentById(tUserId, tAuthEntity))
          .called(1);
    });
  });
}
