import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/foster/data/data_source/foster_datasource.dart';
import 'package:furever_home/features/foster/domain/entity/foster_entity.dart';
import 'package:furever_home/features/foster/domain/repository/foster_repository.dart';

class FosterRepository implements IFosterRepository {
  final IFosterDataSource _fosterDataSource;

  FosterRepository(this._fosterDataSource);

  @override
  Future<Either<Failure, void>> createFoster(
      FosterApplicationEntity fosterApplication) async {
    try {
      await _fosterDataSource.submitFosterApplication(fosterApplication);
      return Right(null); // Successful operation
    } catch (e) {
      throw Exception("Failed to submit foster application: ${e.toString()}");
    }
  }
}
