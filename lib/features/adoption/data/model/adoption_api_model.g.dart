// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdoptionApiModel _$AdoptionApiModelFromJson(Map<String, dynamic> json) =>
    AdoptionApiModel(
      applicantId: json['applicantId'] as String,
      petId: json['petId'] as String,
      applicantName: json['applicantName'] as String,
      applicantEmail: json['applicantEmail'] as String,
      applicantPhone: json['applicantPhone'] as String,
      districtOrCity: json['districtOrCity'] as String,
      homeAddress: json['homeAddress'] as String,
      householdMembers: (json['householdMembers'] as num).toInt(),
      hasPets: json['hasPets'] as bool,
      petDetails: json['petDetails'] as String,
      residenceType: json['residenceType'] as String,
      reasonForAdoption: json['reasonForAdoption'] as String,
      experienceWithPets: json['experienceWithPets'] as String,
      agreementToTerms: json['agreementToTerms'] as bool,
    );

Map<String, dynamic> _$AdoptionApiModelToJson(AdoptionApiModel instance) =>
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
      'reasonForAdoption': instance.reasonForAdoption,
      'experienceWithPets': instance.experienceWithPets,
      'agreementToTerms': instance.agreementToTerms,
    };
