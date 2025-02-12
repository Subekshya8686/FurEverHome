import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:hive/hive.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'pet_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.petTableId)
class PetModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final String breed;

  @HiveField(5)
  final int age;

  @HiveField(6)
  final double weight;

  @HiveField(7)
  final bool vaccinated;

  @HiveField(8)
  final bool specialNeeds;

  @HiveField(9)
  final String? healthDetails;

  @HiveField(10)
  final double? height;

  @HiveField(11)
  final String? furType;

  @HiveField(12)
  final String? color;

  @HiveField(13)
  final String? eyeColor;

  @HiveField(14)
  final DateTime? dateOfBirth;

  @HiveField(15)
  final DateTime? dateAdded;

  @HiveField(16)
  final String? adoptionStatus;

  @HiveField(17)
  final List<String>? bookmarkedBy;

  @HiveField(18)
  final String? photo;

  PetModel({
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

  // Convert from Entity to Model
  factory PetModel.fromEntity(PetEntity entity) {
    return PetModel(
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

  // Convert from Model to Entity
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
}
