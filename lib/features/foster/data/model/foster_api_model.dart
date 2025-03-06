import 'package:furever_home/features/foster/domain/entity/foster_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'foster_api_model.g.dart';

@JsonSerializable()
class FosterApplicationRemoteModel {
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

  FosterApplicationRemoteModel({
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

  // Factory methods for JSON serialization
  factory FosterApplicationRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$FosterApplicationRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FosterApplicationRemoteModelToJson(this);

  // fromEntity method to map from FosterApplicationEntity to FosterApplicationRemoteModel
  static FosterApplicationRemoteModel fromEntity(
      FosterApplicationEntity entity) {
    return FosterApplicationRemoteModel(
      applicantId: entity.applicantId,
      petId: entity.petId,
      applicantName: entity.applicantName,
      applicantEmail: entity.applicantEmail,
      applicantPhone: entity.applicantPhone,
      districtOrCity: entity.districtOrCity,
      homeAddress: entity.homeAddress,
      householdMembers: entity.householdMembers,
      hasPets: entity.hasPets,
      petDetails: entity.petDetails,
      residenceType: entity.residenceType,
      reasonForFostering: entity.reasonForFostering,
      experienceWithPets: entity.experienceWithPets,
      availabilityDuration: entity.availabilityDuration,
      abilityToHandleMedicalNeeds: entity.abilityToHandleMedicalNeeds,
      hasFencedYard: entity.hasFencedYard,
      agreementToTerms: entity.agreementToTerms,
    );
  }
}
