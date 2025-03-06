import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/domain/repository/pet_repository.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_all_pets_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mocking the repository
class MockPetRepository extends Mock implements IPetRepository {}

void main() {
  late GetAllPetsUseCase getAllPetsUseCase;
  late MockPetRepository mockPetRepository;

  // Test data
  final tPetList = [
    PetEntity(
      id: '1',
      name: 'Buddy',
      description: 'Friendly dog',
      type: 'Dog',
      breed: 'Golden Retriever',
      age: 3,
      weight: 25.0,
      vaccinated: true,
      specialNeeds: false,
      healthDetails: 'No health issues',
      height: 50.0,
      furType: 'Short',
      color: 'Golden',
      eyeColor: 'Brown',
      dateOfBirth: DateTime(2020, 1, 1),
      dateAdded: DateTime(2023, 1, 1),
      adoptionStatus: 'Available',
      bookmarkedBy: ['user1', 'user2'],
      photo: 'https://example.com/photo.jpg',
    ),
    PetEntity(
      id: '2',
      name: 'Max',
      description: 'Loyal dog',
      type: 'Dog',
      breed: 'Labrador',
      age: 4,
      weight: 30.0,
      vaccinated: true,
      specialNeeds: true,
      healthDetails: 'Needs medication for arthritis',
      height: 55.0,
      furType: 'Short',
      color: 'Black',
      eyeColor: 'Green',
      dateOfBirth: DateTime(2019, 5, 15),
      dateAdded: DateTime(2023, 2, 15),
      adoptionStatus: 'Adopted',
      bookmarkedBy: ['user3'],
      photo: 'https://example.com/photo2.jpg',
    ),
  ];

  setUp(() {
    mockPetRepository = MockPetRepository();
    getAllPetsUseCase = GetAllPetsUseCase(repository: mockPetRepository);
  });

  group('GetAllPetsUseCase', () {
    test('should return list of pets when the repository call is successful',
        () async {
      // Arrange
      when(() => mockPetRepository.getAllPets())
          .thenAnswer((_) async => Right(tPetList));

      // Act
      final result = await getAllPetsUseCase();

      // Assert
      expect(result, Right(tPetList));
      verify(() => mockPetRepository.getAllPets()).called(1);
    });

    test('should return failure when the repository call fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Failed to fetch pets');
      when(() => mockPetRepository.getAllPets())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await getAllPetsUseCase();

      // Assert
      expect(result, Left(failure));
      verify(() => mockPetRepository.getAllPets()).called(1);
    });
  });
}
