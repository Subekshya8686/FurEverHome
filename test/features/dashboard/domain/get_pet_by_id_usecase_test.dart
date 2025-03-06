import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/domain/repository/pet_repository.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_pet_by_id_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mocking the IPetRepository
class MockPetRepository extends Mock implements IPetRepository {}

void main() {
  late GetPetByIdUseCase useCase;
  late MockPetRepository mockPetRepository;

  const tPetId = 'pet123';
  var tPetEntity = PetEntity(
    id: '1',
    name: 'Buddy',
    type: 'Dog',
    breed: 'Labrador',
    age: 5,
    weight: 20.5,
    vaccinated: true,
    specialNeeds: false,
    healthDetails: 'Healthy',
    height: 60.0,
    furType: 'Short',
    color: 'Brown',
    eyeColor: 'Brown',
    dateOfBirth: DateTime(2018, 5, 10),
    dateAdded: DateTime(2023, 2, 7),
    photo: null,
  );

  setUp(() {
    mockPetRepository = MockPetRepository();
    useCase = GetPetByIdUseCase(mockPetRepository);
  });

  group('GetPetByIdUseCase', () {
    test('should return PetEntity when the repository call is successful',
        () async {
      // Arrange
      when(() => mockPetRepository.getPetById(any()))
          .thenAnswer((_) async => Right(tPetEntity));

      // Act
      final result = await useCase(GetPetByIdParams(petId: tPetId));

      // Assert
      expect(result, Right(tPetEntity));
      verify(() => mockPetRepository.getPetById(tPetId)).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Pet not found');
      when(() => mockPetRepository.getPetById(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(GetPetByIdParams(petId: tPetId));

      // Assert
      expect(result, Left(failure));
      verify(() => mockPetRepository.getPetById(tPetId)).called(1);
    });
  });
}
