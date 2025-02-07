import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/domain/repository/pet_repository.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_all_pets_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Create a mock class for the IPetRepository
class MockPetRepository extends Mock implements IPetRepository {}

void main() {
  late GetAllPetsUseCase useCase;
  late MockPetRepository mockRepository;

  setUp(() {
    mockRepository = MockPetRepository();
    useCase = GetAllPetsUseCase(repository: mockRepository);

    // Register fallback values for the mocks to handle unknown methods
    registerFallbackValue(ApiFailure(message: 'Unknown error'));
  });

  group('GetAllPetsUseCase', () {
    test('should return a list of PetEntity on success', () async {
      // Arrange
      final pets = [
        PetEntity(
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
        ),
        PetEntity(
          id: '2',
          name: 'Max',
          type: 'Cat',
          breed: 'Siamese',
          age: 3,
          weight: 10.2,
          vaccinated: true,
          specialNeeds: false,
          healthDetails: 'Healthy',
          height: 45.0,
          furType: 'Short',
          color: 'Gray',
          eyeColor: 'Green',
          dateOfBirth: DateTime(2020, 7, 2),
          dateAdded: DateTime(2023, 2, 7),
          photo: null,
        ),
      ];

      // Mock the repository response
      when(() => mockRepository.getAllPets())
          .thenAnswer((_) async => Right(pets));

      // Act
      final result = await useCase();

      // Assert
      expect(result, Right(pets));
      verify(() => mockRepository.getAllPets()).called(1);
    });

    test('should return a Failure on repository error', () async {
      // Arrange
      final failure = ApiFailure(message: 'Failed to fetch pets');
      when(() => mockRepository.getAllPets())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, Left(failure));
      verify(() => mockRepository.getAllPets()).called(1);
    });
  });
}
