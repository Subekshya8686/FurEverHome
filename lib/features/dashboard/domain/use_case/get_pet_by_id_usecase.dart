import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:furever_home/app/usecase/usecase.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/domain/repository/pet_repository.dart';

class GetPetByIdParams extends Equatable {
  final String petId;

  const GetPetByIdParams({required this.petId});

  @override
  List<Object?> get props => [petId];
}

class GetPetByIdUseCase
    implements UsecaseWithParams<PetEntity, GetPetByIdParams> {
  final IPetRepository repository;

  GetPetByIdUseCase(this.repository);

  @override
  Future<Either<Failure, PetEntity>> call(GetPetByIdParams params) async {
    try {
      return await repository.getPetById(params.petId);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Failed to fetch pet: $e'));
    }
  }
}
