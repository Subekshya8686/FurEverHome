import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/adoption/domain/entity/adoption_entity.dart';
import 'package:furever_home/features/adoption/domain/repository/adoption_repository.dart';

class CreateAdoptionParams extends Equatable {
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
  final String reasonForAdoption;
  final String experienceWithPets;
  final bool agreementToTerms;

  const CreateAdoptionParams({
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
    required this.reasonForAdoption,
    required this.experienceWithPets,
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
        reasonForAdoption,
        experienceWithPets,
        agreementToTerms,
      ];
}

class CreateAdoptionUsecase
    implements UsecaseWithParams<void, CreateAdoptionParams> {
  final IAdoptionRepository repository;

  CreateAdoptionUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateAdoptionParams params) async {
    try {
      // Create an AdoptionEntity object from the params
      final adoption = AdoptionEntity(
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
        reasonForAdoption: params.reasonForAdoption,
        experienceWithPets: params.experienceWithPets,
        agreementToTerms: params.agreementToTerms,
      );

      // Call the repository to create the adoption request
      return await repository.createAdoption(adoption);
    } catch (error) {
      // Handle exceptions and return a Failure
      return Left(Failure(message: error.toString()));
    }
  }
}
