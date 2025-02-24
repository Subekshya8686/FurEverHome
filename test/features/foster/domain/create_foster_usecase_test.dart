import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/foster/domain/entity/foster_entity.dart';
import 'package:furever_home/features/foster/domain/repository/foster_repository.dart';
import 'package:furever_home/features/foster/domain/use_case/create_foster_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mocking dependencies
class MockFosterRepository extends Mock implements IFosterRepository {}

void main() {
  late CreateFosterUseCase createFosterUseCase;
  late MockFosterRepository mockFosterRepository;

  // Test data
  const tApplicantId = 'applicant_id';
  const tPetId = 'pet_id';
  const tApplicantName = 'John Doe';
  const tApplicantEmail = 'johndoe@example.com';
  const tApplicantPhone = '1234567890';
  const tDistrictOrCity = 'New York';
  const tHomeAddress = '123 Main St';
  const tHouseholdMembers = 4;
  const tHasPets = true;
  const tPetDetails = 'Labrador, 2 years old';
  const tResidenceType = 'House';
  const tReasonForFostering = 'Temporary care';
  const tExperienceWithPets = 'Yes';
  const tAvailabilityDuration = '6 months';
  const tAbilityToHandleMedicalNeeds = true;
  const tHasFencedYard = true;
  const tAgreementToTerms = true;

  final tCreateFosterParams = CreateFosterParams(
    applicantId: tApplicantId,
    petId: tPetId,
    applicantName: tApplicantName,
    applicantEmail: tApplicantEmail,
    applicantPhone: tApplicantPhone,
    districtOrCity: tDistrictOrCity,
    homeAddress: tHomeAddress,
    householdMembers: tHouseholdMembers,
    hasPets: tHasPets,
    petDetails: tPetDetails,
    residenceType: tResidenceType,
    reasonForFostering: tReasonForFostering,
    experienceWithPets: tExperienceWithPets,
    availabilityDuration: tAvailabilityDuration,
    abilityToHandleMedicalNeeds: tAbilityToHandleMedicalNeeds,
    hasFencedYard: tHasFencedYard,
    agreementToTerms: tAgreementToTerms,
  );

  // Registering fallback value for FosterApplicationEntity
  setUpAll(() {
    registerFallbackValue(FosterApplicationEntity(
      applicantId: '',
      petId: '',
      applicantName: '',
      applicantEmail: '',
      applicantPhone: '',
      districtOrCity: '',
      homeAddress: '',
      householdMembers: 0,
      hasPets: false,
      petDetails: '',
      residenceType: '',
      reasonForFostering: '',
      experienceWithPets: '',
      availabilityDuration: '',
      abilityToHandleMedicalNeeds: false,
      hasFencedYard: false,
      agreementToTerms: false,
    ));
  });

  setUp(() {
    mockFosterRepository = MockFosterRepository();
    createFosterUseCase = CreateFosterUseCase(mockFosterRepository);
  });

  group('CreateFosterUseCase', () {
    test('should call repository to create foster application successfully',
        () async {
      // Arrange
      when(() => mockFosterRepository.createFoster(any()))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await createFosterUseCase(tCreateFosterParams);

      // Assert
      expect(result, Right(null));
      verify(() => mockFosterRepository.createFoster(any())).called(1);
    });

    test('should return failure when foster creation fails', () async {
      // Arrange
      final failure =
          ApiFailure(message: 'Failed to create foster application');
      when(() => mockFosterRepository.createFoster(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await createFosterUseCase(tCreateFosterParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockFosterRepository.createFoster(any())).called(1);
    });
  });
}
