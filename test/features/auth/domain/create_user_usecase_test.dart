import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/create_user_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mocking dependencies
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late CreateStudentUsecase createStudentUsecase;
  late MockAuthRepository mockAuthRepository;

  // Test data
  const tFname = 'John';
  const tLname = 'Doe';
  const tEmail = 'johndoe@example.com';
  const tPassword = 'password';
  const tPhone = '1234567890';

  final tCreateStudentParams = CreateStudentParams(
    fname: tFname,
    lname: tLname,
    email: tEmail,
    password: tPassword,
    phone: tPhone,
  );

  setUpAll(() {
    // Register fallback value for AuthEntity
    registerFallbackValue(AuthEntity(
      fname: '',
      lname: '',
      email: '',
      phone: '',
      password: '',
    ));
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    createStudentUsecase = CreateStudentUsecase(mockAuthRepository);
  });

  group('CreateStudentUsecase', () {
    test('should call repository to create student successfully', () async {
      // Arrange
      when(() => mockAuthRepository.addStudent(any()))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await createStudentUsecase(tCreateStudentParams);

      // Assert
      expect(result, Right(null));
      verify(() => mockAuthRepository.addStudent(any())).called(1);
    });

    test('should return failure when creation fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Failed to create student');
      when(() => mockAuthRepository.addStudent(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await createStudentUsecase(tCreateStudentParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.addStudent(any())).called(1);
    });
  });
}
