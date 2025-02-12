import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/adoption/data/data_source/adoption_remote_datasource/adoption_remote_datasource.dart';
import 'package:furever_home/features/adoption/domain/entity/adoption_entity.dart';
import 'package:furever_home/features/adoption/domain/repository/adoption_repository.dart';

class AdoptionRepository implements IAdoptionRepository {
  final AdoptionRemoteDatasource _adoptionRemoteDatasource;

  AdoptionRepository(this._adoptionRemoteDatasource);

  @override
  Future<Either<Failure, void>> createAdoption(AdoptionEntity adoption) async {
    try {
      await _adoptionRemoteDatasource
          .createAdoption(adoption); // Calls the remote data source
      return Right(null); // Successful operation
    } catch (e) {
      return Left(ApiFailure(
          message: e.toString())); // Handle failure and return an error message
    }
  }
}
