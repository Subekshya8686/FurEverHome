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
      type: fields[2] as String,
      breed: fields[3] as String,
      age: fields[4] as int,
      weight: fields[5] as double,
      vaccinated: fields[6] as bool,
      specialNeeds: fields[7] as bool,
      healthDetails: fields[8] as String,
      height: fields[9] as double,
      furType: fields[10] as String,
      color: fields[11] as String,
      eyeColor: fields[12] as String,
      dateOfBirth: fields[13] as DateTime,
      dateAdded: fields[14] as DateTime,
      photo: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PetModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.breed)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.vaccinated)
      ..writeByte(7)
      ..write(obj.specialNeeds)
      ..writeByte(8)
      ..write(obj.healthDetails)
      ..writeByte(9)
      ..write(obj.height)
      ..writeByte(10)
      ..write(obj.furType)
      ..writeByte(11)
      ..write(obj.color)
      ..writeByte(12)
      ..write(obj.eyeColor)
      ..writeByte(13)
      ..write(obj.dateOfBirth)
      ..writeByte(14)
      ..write(obj.dateAdded)
      ..writeByte(15)
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
