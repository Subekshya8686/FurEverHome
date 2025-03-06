import 'package:equatable/equatable.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet_api_model.g.dart';

@JsonSerializable()
class PetApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final String description;
  final String type;
  final String breed;
  final int age;
  final double weight;
  final bool vaccinated;
  final bool specialNeeds;
  final String? healthDetails;
  final double? height;
  final String? furType;
  final String? color;
  final String? eyeColor;
  final DateTime? dateOfBirth;
  final DateTime? dateAdded;
  final String? adoptionStatus;
  final List<String>? bookmarkedBy;
  final String? photo;

  const PetApiModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.breed,
    required this.age,
    required this.weight,
    required this.vaccinated,
    required this.specialNeeds,
    this.healthDetails,
    this.height,
    this.furType,
    this.color,
    this.eyeColor,
    this.dateOfBirth,
    this.dateAdded,
    this.adoptionStatus,
    this.bookmarkedBy,
    this.photo,
  });

  // Convert JSON to PetApiModel
  factory PetApiModel.fromJson(Map<String, dynamic> json) =>
      _$PetApiModelFromJson(json);

  // Convert PetApiModel to JSON
  Map<String, dynamic> toJson() => _$PetApiModelToJson(this);

  // Convert to Entity
  PetEntity toEntity() {
    return PetEntity(
      id: id,
      name: name,
      description: description,
      type: type,
      breed: breed,
      age: age,
      weight: weight,
      vaccinated: vaccinated,
      specialNeeds: specialNeeds,
      healthDetails: healthDetails,
      height: height,
      furType: furType,
      color: color,
      eyeColor: eyeColor,
      dateOfBirth: dateOfBirth,
      dateAdded: dateAdded,
      adoptionStatus: adoptionStatus,
      bookmarkedBy: bookmarkedBy,
      photo: photo,
    );
  }

  // Convert from Entity
  factory PetApiModel.fromEntity(PetEntity entity) {
    return PetApiModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      type: entity.type,
      breed: entity.breed,
      age: entity.age,
      weight: entity.weight,
      vaccinated: entity.vaccinated,
      specialNeeds: entity.specialNeeds,
      healthDetails: entity.healthDetails,
      height: entity.height,
      furType: entity.furType,
      color: entity.color,
      eyeColor: entity.eyeColor,
      dateOfBirth: entity.dateOfBirth,
      dateAdded: entity.dateAdded,
      adoptionStatus: entity.adoptionStatus,
      bookmarkedBy: entity.bookmarkedBy,
      photo: entity.photo,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        type,
        breed,
        age,
        weight,
        vaccinated,
        specialNeeds,
        healthDetails,
        height,
        furType,
        color,
        eyeColor,
        dateOfBirth,
        dateAdded,
        adoptionStatus,
        bookmarkedBy,
        photo,
      ];
}
