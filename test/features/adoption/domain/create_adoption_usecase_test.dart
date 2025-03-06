import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/adoption/domain/entity/adoption_entity.dart';
import 'package:furever_home/features/adoption/domain/repository/adoption_repository.dart';
import 'package:furever_home/features/adoption/domain/use_case/create_adoption_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Mocking dependencies
class MockAdoptionRepository extends Mock implements IAdoptionRepository {}

void main() {
  late CreateAdoptionUsecase createAdoptionUsecase;
  late MockAdoptionRepository mockAdoptionRepository;

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
  const tReasonForAdoption = 'Companionship';
  const tExperienceWithPets = 'Yes';
  const tAgreementToTerms = true;

  final tCreateAdoptionParams = CreateAdoptionParams(
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
    reasonForAdoption: tReasonForAdoption,
    experienceWithPets: tExperienceWithPets,
    agreementToTerms: tAgreementToTerms,
  );

  // Registering fallback value for AdoptionEntity
  setUpAll(() {
    registerFallbackValue(AdoptionEntity(
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
      reasonForAdoption: '',
      experienceWithPets: '',
      agreementToTerms: false,
    ));
  });

  setUp(() {
    mockAdoptionRepository = MockAdoptionRepository();
    createAdoptionUsecase = CreateAdoptionUsecase(mockAdoptionRepository);
  });

  group('CreateAdoptionUsecase', () {
    test('should call repository to create adoption successfully', () async {
      // Arrange
      when(() => mockAdoptionRepository.createAdoption(any()))
          .thenAnswer((_) async => Right(null));

      // Act
      final result = await createAdoptionUsecase(tCreateAdoptionParams);

      // Assert
      expect(result, Right(null));
      verify(() => mockAdoptionRepository.createAdoption(any())).called(1);
    });

    test('should return failure when adoption creation fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Failed to create adoption');
      when(() => mockAdoptionRepository.createAdoption(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await createAdoptionUsecase(tCreateAdoptionParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockAdoptionRepository.createAdoption(any())).called(1);
    });
  });
}
