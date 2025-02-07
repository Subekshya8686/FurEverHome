import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/delete_user_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late DeleteStudentUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  const tStudentId = 'student123';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = DeleteStudentUsecase(mockAuthRepository);
  });

  group('DeleteStudentUsecase', () {
    test('should return void when student is successfully deleted', () async {
      // Arrange
      when(() => mockAuthRepository.deleteStudent(any()))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await usecase(DeleteStudentParams(studentId: tStudentId));

      // Assert
      expect(result, Right(null));
      verify(() => mockAuthRepository.deleteStudent(tStudentId)).called(1);
    });

    test('should return failure when an error occurs during deletion',
        () async {
      // Arrange
      final failure = ApiFailure(message: 'Failed to delete student');
      when(() => mockAuthRepository.deleteStudent(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await usecase(DeleteStudentParams(studentId: tStudentId));

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.deleteStudent(tStudentId)).called(1);
    });
  });
}
