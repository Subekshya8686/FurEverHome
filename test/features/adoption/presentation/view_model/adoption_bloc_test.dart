import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/adoption/domain/use_case/create_adoption_usecase.dart';
import 'package:furever_home/features/adoption/presentation/view_model/adoption_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockCreateAdoptionUsecase extends Mock implements CreateAdoptionUsecase {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AdoptionBloc adoptionBloc;
  late MockCreateAdoptionUsecase mockCreateAdoptionUsecase;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockCreateAdoptionUsecase = MockCreateAdoptionUsecase();
    mockSharedPreferences = MockSharedPreferences();
    adoptionBloc =
        AdoptionBloc(createAdoptionUsecase: mockCreateAdoptionUsecase);

    // Mock shared preferences to return a fake applicantId when requested.
    when(() => mockSharedPreferences.getString('userId'))
        .thenReturn('test_user_id');
  });

  group('AdoptionBloc', () {
    final createAdoptionEvent = CreateAdoptionEvent(
      petId: '1',
      applicantName: 'John Doe',
      applicantEmail: 'johndoe@example.com',
      applicantPhone: '1234567890',
      districtOrCity: 'New York',
      homeAddress: '123 Street',
      householdMembers: 3,
      hasPets: true,
      petDetails: 'Details about the pet.',
      residenceType: 'Apartment',
      reasonForAdoption: 'Love for animals',
      experienceWithPets: 'Yes',
      agreementToTerms: true,
      applicantId: 'test_user_id',
    );

    blocTest<AdoptionBloc, AdoptionState>(
      'emits [isLoading: true, isSuccess: true] when adoption is created successfully',
      build: () {
        // Mock the use case to return success
        when(() => mockCreateAdoptionUsecase.call(any()))
            .thenAnswer((_) async => Right('Success'));
        return adoptionBloc;
      },
      act: (bloc) => bloc.add(createAdoptionEvent),
      expect: () => [
        AdoptionState.initial().copyWith(isLoading: true),
        AdoptionState.initial().copyWith(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockCreateAdoptionUsecase.call(any())).called(1);
      },
    );

    blocTest<AdoptionBloc, AdoptionState>(
      'emits [isLoading: true, isSuccess: false] when adoption creation fails',
      build: () {
        // Mock the use case to return failure
        when(() => mockCreateAdoptionUsecase.call(any()))
            .thenAnswer((_) async => Left(Failure(message: "failed")));
        return adoptionBloc;
      },
      act: (bloc) => bloc.add(createAdoptionEvent),
      expect: () => [
        AdoptionState.initial().copyWith(isLoading: true),
        AdoptionState.initial().copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockCreateAdoptionUsecase.call(any())).called(1);
      },
    );

    blocTest<AdoptionBloc, AdoptionState>(
      'emits [isLoading: true, isSuccess: false] when userId is null',
      build: () {
        // Mock shared preferences to return null for userId
        when(() => mockSharedPreferences.getString('userId')).thenReturn(null);
        return adoptionBloc;
      },
      act: (bloc) => bloc.add(createAdoptionEvent),
      expect: () => [
        AdoptionState.initial().copyWith(isLoading: true),
        AdoptionState.initial().copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockSharedPreferences.getString('userId')).called(1);
      },
    );
  });
}
