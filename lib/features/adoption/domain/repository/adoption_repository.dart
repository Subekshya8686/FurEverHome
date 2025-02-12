import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/adoption/domain/entity/adoption_entity.dart';

abstract class IAdoptionRepository {
  Future<Either<Failure, void>> createAdoption(AdoptionEntity adoption);
}
