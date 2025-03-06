// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetModelAdapter extends TypeAdapter<PetModel> {
  @override
  final int typeId = 1;

  @override
  PetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      type: fields[3] as String,
      breed: fields[4] as String,
      age: fields[5] as int,
      weight: fields[6] as double,
      vaccinated: fields[7] as bool,
      specialNeeds: fields[8] as bool,
      healthDetails: fields[9] as String?,
      height: fields[10] as double?,
      furType: fields[11] as String?,
      color: fields[12] as String?,
      eyeColor: fields[13] as String?,
      dateOfBirth: fields[14] as DateTime?,
      dateAdded: fields[15] as DateTime?,
      adoptionStatus: fields[16] as String?,
      bookmarkedBy: (fields[17] as List?)?.cast<String>(),
      photo: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PetModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.breed)
      ..writeByte(5)
      ..write(obj.age)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.vaccinated)
      ..writeByte(8)
      ..write(obj.specialNeeds)
      ..writeByte(9)
      ..write(obj.healthDetails)
      ..writeByte(10)
      ..write(obj.height)
      ..writeByte(11)
      ..write(obj.furType)
      ..writeByte(12)
      ..write(obj.color)
      ..writeByte(13)
      ..write(obj.eyeColor)
      ..writeByte(14)
      ..write(obj.dateOfBirth)
      ..writeByte(15)
      ..write(obj.dateAdded)
      ..writeByte(16)
      ..write(obj.adoptionStatus)
      ..writeByte(17)
      ..write(obj.bookmarkedBy)
      ..writeByte(18)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
