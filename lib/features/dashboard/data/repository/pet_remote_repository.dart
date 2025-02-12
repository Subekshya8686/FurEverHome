import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/data/data_source/pet_datasource.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/domain/repository/pet_repository.dart';

class PetRemoteRepository implements IPetRepository {
  final IPetDataSource _petRemoteDatasource;

  PetRemoteRepository(this._petRemoteDatasource);

  // Fetch all pets
  @override
  Future<Either<Failure, List<PetEntity>>> getAllPets() async {
    try {
      // Get the result from the data source
      final result = await _petRemoteDatasource.getAllPets();

      print("result $result");

      // Check if result is null, return empty list instead
      if (result == null) {
        return Right([]); // Return an empty list if null
      }

      // Return the result directly if successful, or return the failure if not
      return result.fold(
        (failure) => Left(failure), // If there was an error in data source
        (petsApiModels) => Right(petsApiModels), // Directly return the result
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  // Fetch pet by ID
  @override
  Future<Either<Failure, PetEntity>> getPetById(String id) async {
    try {
      // Get the result from the data source
      final result = await _petRemoteDatasource.getPetById(id);

      // Return the result directly if successful, or return the failure if not
      return result.fold(
        (failure) => Left(failure), // If there was an error in data source
        (petApiModel) => Right(petApiModel), // Directly return the result
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
