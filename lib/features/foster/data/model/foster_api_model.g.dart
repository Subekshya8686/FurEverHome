// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foster_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FosterApplicationRemoteModel _$FosterApplicationRemoteModelFromJson(
        Map<String, dynamic> json) =>
    FosterApplicationRemoteModel(
      applicantId: json['applicantId'] as String,
      petId: json['petId'] as String,
      applicantName: json['applicantName'] as String,
      applicantEmail: json['applicantEmail'] as String,
      applicantPhone: json['applicantPhone'] as String,
      districtOrCity: json['districtOrCity'] as String,
      homeAddress: json['homeAddress'] as String,
      householdMembers: (json['householdMembers'] as num).toInt(),
      hasPets: json['hasPets'] as bool,
      petDetails: json['petDetails'] as String?,
      residenceType: json['residenceType'] as String,
      reasonForFostering: json['reasonForFostering'] as String,
      experienceWithPets: json['experienceWithPets'] as String,
      availabilityDuration: json['availabilityDuration'] as String,
      abilityToHandleMedicalNeeds: json['abilityToHandleMedicalNeeds'] as bool,
      hasFencedYard: json['hasFencedYard'] as bool,
      agreementToTerms: json['agreementToTerms'] as bool,
    );

Map<String, dynamic> _$FosterApplicationRemoteModelToJson(
        FosterApplicationRemoteModel instance) =>
    <String, dynamic>{
      'applicantId': instance.applicantId,
      'petId': instance.petId,
      'applicantName': instance.applicantName,
      'applicantEmail': instance.applicantEmail,
      'applicantPhone': instance.applicantPhone,
      'districtOrCity': instance.districtOrCity,
      'homeAddress': instance.homeAddress,
      'householdMembers': instance.householdMembers,
      'hasPets': instance.hasPets,
      'petDetails': instance.petDetails,
      'residenceType': instance.residenceType,
      'reasonForFostering': instance.reasonForFostering,
      'experienceWithPets': instance.experienceWithPets,
      'availabilityDuration': instance.availabilityDuration,
      'abilityToHandleMedicalNeeds': instance.abilityToHandleMedicalNeeds,
      'hasFencedYard': instance.hasFencedYard,
      'agreementToTerms': instance.agreementToTerms,
    };
