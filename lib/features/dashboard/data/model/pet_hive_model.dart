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
  final String type;

  @HiveField(3)
  final String breed;

  @HiveField(4)
  final int age;

  @HiveField(5)
  final double weight;

  @HiveField(6)
  final bool vaccinated;

  @HiveField(7)
  final bool specialNeeds;

  @HiveField(8)
  final String healthDetails;

  @HiveField(9)
  final double height;

  @HiveField(10)
  final String furType;

  @HiveField(11)
  final String color;

  @HiveField(12)
  final String eyeColor;

  @HiveField(13)
  final DateTime dateOfBirth;

  @HiveField(14)
  final DateTime dateAdded;

  @HiveField(15)
  final String? photo;

  PetModel({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.weight,
    required this.vaccinated,
    required this.specialNeeds,
    required this.healthDetails,
    required this.height,
    required this.furType,
    required this.color,
    required this.eyeColor,
    required this.dateOfBirth,
    required this.dateAdded,
    this.photo,
  });

  // Convert from Entity to Model
  factory PetModel.fromEntity(PetEntity entity) {
    return PetModel(
      id: entity.id,
      name: entity.name,
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
      photo: entity.photo,
    );
  }

  // Convert from Model to Entity
  PetEntity toEntity() {
    return PetEntity(
      id: id,
      name: name,
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
      photo: photo,
    );
  }
}
