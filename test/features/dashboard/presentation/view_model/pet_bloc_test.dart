import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_all_pets_usecase.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_pet_by_id_usecase.dart';
import 'package:furever_home/features/dashboard/presentation/view_model/pet_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mocking the use cases
class MockGetAllPetsUseCase extends Mock implements GetAllPetsUseCase {}

class MockGetPetByIdUseCase extends Mock implements GetPetByIdUseCase {}

void main() {
  late PetBloc petBloc;
  late MockGetAllPetsUseCase mockGetAllPetsUseCase;
  late MockGetPetByIdUseCase mockGetPetByIdUseCase;

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
    // Mocking both use cases
    mockGetAllPetsUseCase = MockGetAllPetsUseCase();
    mockGetPetByIdUseCase = MockGetPetByIdUseCase();

    // Passing both use cases to the PetBloc constructor
    petBloc = PetBloc(
      getAllPetsUseCase: mockGetAllPetsUseCase,
      getPetByIdUseCase:
          mockGetPetByIdUseCase, // Ensure both parameters are passed
    );
  });

  group('PetBloc', () {
    blocTest<PetBloc, PetState>(
      'emits PetLoadingState and then PetLoadedState when GetAllPetsEvent is added',
      build: () {
        when(() => mockGetAllPetsUseCase())
            .thenAnswer((_) async => Right(tPetList));
        return petBloc;
      },
      act: (bloc) => bloc.add(GetAllPetsEvent()),
      expect: () => [
        PetLoadingState(),
        PetLoadedState(tPetList),
      ],
    );

    blocTest<PetBloc, PetState>(
      'emits PetLoadingState and then PetErrorState when GetAllPetsUseCase fails',
      build: () {
        final failure = ApiFailure(message: 'Failed to fetch pets');
        when(() => mockGetAllPetsUseCase())
            .thenAnswer((_) async => Left(failure));
        return petBloc;
      },
      act: (bloc) => bloc.add(GetAllPetsEvent()),
      expect: () => [
        PetLoadingState(),
        PetErrorState('Failed to fetch pets'),
      ],
    );
  });
}
