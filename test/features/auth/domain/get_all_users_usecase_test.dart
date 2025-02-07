import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/get_all_users_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late GetAllStudentsUsecase usecase;
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
  const List<AuthEntity> tStudents = [tAuthEntity];

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetAllStudentsUsecase(mockAuthRepository);
  });

  group('GetAllStudentsUsecase', () {
    test('should return a list of students when repository succeeds', () async {
      // Arrange
      when(() => mockAuthRepository.getAllStudents())
          .thenAnswer((_) async => Right(tStudents));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Right(tStudents));
      verify(() => mockAuthRepository.getAllStudents()).called(1);
    });

    test('should return a failure when repository throws an error', () async {
      // Arrange
      final failure = ApiFailure(message: 'Failed to get students');
      when(() => mockAuthRepository.getAllStudents())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.getAllStudents()).called(1);
    });
  });
}
