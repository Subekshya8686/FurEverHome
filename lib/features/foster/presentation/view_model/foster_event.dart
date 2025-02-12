part of 'foster_bloc.dart';

sealed class FosterFormEvent extends Equatable {
  const FosterFormEvent();

  @override
  List<Object> get props => [];
}

class SubmitFormEvent extends FosterFormEvent {
  final String applicantId;
  final String petId;
  final String applicantName;
  final String applicantEmail;
  final String applicantPhone;
  final String districtOrCity;
  final String homeAddress;
  final int householdMembers;
  final bool hasPets;
  final String? petDetails; // Optional field
  final String residenceType;
  final String reasonForFostering;
  final String experienceWithPets;
  final String availabilityDuration;
  final bool abilityToHandleMedicalNeeds;
  final bool hasFencedYard;
  final bool agreementToTerms;

  const SubmitFormEvent({
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
  List<Object> get props => [
        applicantId,
        petId,
        applicantName,
        applicantEmail,
        applicantPhone,
        districtOrCity,
        homeAddress,
        householdMembers,
        hasPets,
        petDetails ?? '',
        residenceType,
        reasonForFostering,
        experienceWithPets,
        availabilityDuration,
        abilityToHandleMedicalNeeds,
        hasFencedYard,
        agreementToTerms,
      ];
}
