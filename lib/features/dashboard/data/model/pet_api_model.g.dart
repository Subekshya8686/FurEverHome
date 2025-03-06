// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetApiModel _$PetApiModelFromJson(Map<String, dynamic> json) => PetApiModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      breed: json['breed'] as String,
      age: (json['age'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      vaccinated: json['vaccinated'] as bool,
      specialNeeds: json['specialNeeds'] as bool,
      healthDetails: json['healthDetails'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      furType: json['furType'] as String?,
      color: json['color'] as String?,
      eyeColor: json['eyeColor'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      dateAdded: json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
      adoptionStatus: json['adoptionStatus'] as String?,
      bookmarkedBy: (json['bookmarkedBy'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$PetApiModelToJson(PetApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'breed': instance.breed,
      'age': instance.age,
      'weight': instance.weight,
      'vaccinated': instance.vaccinated,
      'specialNeeds': instance.specialNeeds,
      'healthDetails': instance.healthDetails,
      'height': instance.height,
      'furType': instance.furType,
      'color': instance.color,
      'eyeColor': instance.eyeColor,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'adoptionStatus': instance.adoptionStatus,
      'bookmarkedBy': instance.bookmarkedBy,
      'photo': instance.photo,
    };
