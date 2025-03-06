import 'package:dartz/dartz.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/domain/repository/pet_repository.dart';

class GetAllPetsUseCase implements UsecaseWithoutParams<List<PetEntity>> {
  final IPetRepository repository;

  GetAllPetsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PetEntity>>> call() async {
    try {
      return await repository.getAllPets();
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ApiFailure(message: 'Failed to fetch pets: $e'));
    }
  }
}
