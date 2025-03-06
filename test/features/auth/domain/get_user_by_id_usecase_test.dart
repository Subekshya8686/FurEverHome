import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/get_user_by_id_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late GetUserByIdUseCase usecase;
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

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetUserByIdUseCase(mockAuthRepository);
  });

  group('GetUserByIdUseCase', () {
    test('should return AuthEntity when the repository call is successful',
        () async {
      // Arrange
      when(() => mockAuthRepository.getUserById(any()))
          .thenAnswer((_) async => Right(tAuthEntity));

      // Act
      final result = await usecase(tUserId);

      // Assert
      expect(result, Right(tAuthEntity));
      verify(() => mockAuthRepository.getUserById(tUserId)).called(1);
    });

    test('should return a failure when the repository call fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'User not found');
      when(() => mockAuthRepository.getUserById(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await usecase(tUserId);

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.getUserById(tUserId)).called(1);
    });
  });
}
