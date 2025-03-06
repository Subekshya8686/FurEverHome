import 'package:equatable/equatable.dart';

class AdoptionEntity extends Equatable {
  final String applicantId;
  final String petId;
  final String applicantName;
  final String applicantEmail;
  final String applicantPhone;
  final String districtOrCity;
  final String homeAddress;
  final int householdMembers;
  final bool hasPets;
  final String petDetails;
  final String residenceType;
  final String reasonForAdoption;
  final String experienceWithPets;
  final bool agreementToTerms;

  AdoptionEntity({
    required this.applicantId,
    required this.petId,
    required this.applicantName,
    required this.applicantEmail,
    required this.applicantPhone,
    required this.districtOrCity,
    required this.homeAddress,
    required this.householdMembers,
    required this.hasPets,
    required this.petDetails,
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
