import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/foster/domain/use_case/create_foster_usecase.dart';
import 'package:furever_home/features/foster/presentation/view_model/foster_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockCreateFosterUseCase extends Mock implements CreateFosterUseCase {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late FosterFormBloc fosterFormBloc;
  late CreateFosterUseCase createFosterUseCase;
  late SharedPreferences sharedPreferences;

  setUp(() {
    createFosterUseCase = MockCreateFosterUseCase();
    sharedPreferences = MockSharedPreferences();
    fosterFormBloc = FosterFormBloc(createFosterUseCase: createFosterUseCase);

    // Mock shared preferences to return a fake applicantId when requested.
    when(() => sharedPreferences.getString('userId'))
        .thenReturn('test_user_id');
  });

  group('FosterFormBloc', () {
    final submitEvent = SubmitFormEvent(
      applicantId: 'test_user_id',
      // Add applicantId here
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
      reasonForFostering: 'Love for animals',
      experienceWithPets: 'Yes',
      availabilityDuration: '3 months',
      abilityToHandleMedicalNeeds: true,
      hasFencedYard: false,
      agreementToTerms: true,
    );

    blocTest<FosterFormBloc, FosterFormState>(
      'emits [isLoading: true, isSuccess: true] when the form is successfully submitted',
      build: () {
        when(() => createFosterUseCase.call(any()))
            .thenAnswer((_) async => Right('Success'));
        return fosterFormBloc;
      },
      act: (bloc) => bloc.add(submitEvent),
      expect: () => [
        FosterFormState.initial().copyWith(isLoading: true),
        FosterFormState.initial().copyWith(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => createFosterUseCase.call(any())).called(1);
      },
    );

    blocTest<FosterFormBloc, FosterFormState>(
      'emits [isLoading: true, isSuccess: false] when the form submission fails',
      build: () {
        when(() => createFosterUseCase.call(any()))
            .thenAnswer((_) async => Left(Failure(message: "failed")));
        return fosterFormBloc;
      },
      act: (bloc) => bloc.add(submitEvent),
      expect: () => [
        FosterFormState.initial().copyWith(isLoading: true),
        FosterFormState.initial().copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => createFosterUseCase.call(any())).called(1);
      },
    );
  });
}
