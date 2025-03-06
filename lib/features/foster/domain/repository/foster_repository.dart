import 'package:dartz/dartz.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/foster/domain/entity/foster_entity.dart';

abstract class IFosterRepository {
  Future<Either<Failure, void>> createFoster(
      FosterApplicationEntity fosterApplication);
}
