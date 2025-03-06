import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/repository/auth_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mocking the IAuthRepository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UploadImageUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  var tFile = File('path/to/file');
  const tUploadSuccessMessage = 'Image uploaded successfully';

  // Register a fallback value for File class
  setUpAll(() {
    registerFallbackValue(File('path/to/file'));
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UploadImageUsecase(mockAuthRepository);
  });

  group('UploadImageUsecase', () {
    test('should return success message when the upload is successful',
        () async {
      // Arrange
      when(() => mockAuthRepository.uploadProfilePicture(any()))
          .thenAnswer((_) async => Right(tUploadSuccessMessage));

      // Act
      final result = await usecase(UploadImageParams(file: tFile));

      // Assert
      expect(result, Right(tUploadSuccessMessage));
      verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);
    });

    test('should return failure when the upload fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Upload failed');
      when(() => mockAuthRepository.uploadProfilePicture(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await usecase(UploadImageParams(file: tFile));

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.uploadProfilePicture(tFile)).called(1);
    });
  });
}
