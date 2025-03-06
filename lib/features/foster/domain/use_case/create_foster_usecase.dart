import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/foster/domain/entity/foster_entity.dart';
import 'package:furever_home/features/foster/domain/repository/foster_repository.dart';

class CreateFosterParams extends Equatable {
  final String applicantId;
  final String petId;
  final String applicantName;
  final String applicantEmail;
  final String applicantPhone;
  final String districtOrCity;
  final String homeAddress;
  final int householdMembers;
  final bool hasPets;
  final String? petDetails;
  final String residenceType;
  final String reasonForFostering;
  final String experienceWithPets;
  final String availabilityDuration;
  final bool abilityToHandleMedicalNeeds;
  final bool hasFencedYard;
  final bool agreementToTerms;

  const CreateFosterParams({
    required this.applicantId,
    required this.petId,
    required this.applicantName,
    required this.applicantEmail,
    required this.applicantPhone,
    required this.districtOrCity,
    required this.homeAddress,
    required this.householdMembers,
    required this.hasPets,
    this.petDetails,
    required this.residenceType,
    required this.reasonForFostering,
    required this.experienceWithPets,
    required this.availabilityDuration,
    required this.abilityToHandleMedicalNeeds,
    required this.hasFencedYard,
    required this.agreementToTerms,
  });

  @override
  List<Object?> get props => [
        applicantId,
        petId,
        applicantName,
        applicantEmail,
        applicantPhone,
        districtOrCity,
        homeAddress,
        householdMembers,
        hasPets,
        petDetails,
        residenceType,
        reasonForFostering,
        experienceWithPets,
        availabilityDuration,
        abilityToHandleMedicalNeeds,
        hasFencedYard,
        agreementToTerms,
      ];
}

class CreateFosterUseCase
    implements UsecaseWithParams<void, CreateFosterParams> {
  final IFosterRepository repository;

  CreateFosterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateFosterParams params) async {
    try {
      // Create a FosterApplicationEntity object from the params
      final fosterApplication = FosterApplicationEntity(
        applicantId: params.applicantId,
        petId: params.petId,
        applicantName: params.applicantName,
        applicantEmail: params.applicantEmail,
        applicantPhone: params.applicantPhone,
        districtOrCity: params.districtOrCity,
        homeAddress: params.homeAddress,
        householdMembers: params.householdMembers,
        hasPets: params.hasPets,
        petDetails: params.petDetails ?? "",
        residenceType: params.residenceType,
        reasonForFostering: params.reasonForFostering,
        experienceWithPets: params.experienceWithPets,
        availabilityDuration: params.availabilityDuration,
        abilityToHandleMedicalNeeds: params.abilityToHandleMedicalNeeds,
        hasFencedYard: params.hasFencedYard,
        agreementToTerms: params.agreementToTerms,
      );

      // Call the repository to create the foster application
      return await repository.createFoster(fosterApplication);
    } catch (error) {
      // Handle exceptions and return a Failure
      return Left(Failure(message: error.toString()));
    }
  }
}
