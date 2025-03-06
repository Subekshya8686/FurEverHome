import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';

abstract interface class IPetRepository {
  Future<Either<Failure, List<PetEntity>>> getAllPets();

  Future<Either<Failure, PetEntity>> getPetById(String id);
}
