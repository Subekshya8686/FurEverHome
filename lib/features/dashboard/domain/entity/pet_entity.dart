import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String id;
  final String name;
  final String type;
  final String breed;
  final int age;
  final double weight;
  final bool vaccinated;
  final bool specialNeeds;
  final String healthDetails;
  final double height;
  final String furType;
  final String color;
  final String eyeColor;
  final DateTime dateOfBirth;
  final DateTime dateAdded;
  final String? photo;

  const PetEntity({
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

  @override
  List<Object?> get props => [
        id,
        name,
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
        photo,
      ];
}
