import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:furever_home/app/constants/api_endpoints.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/dashboard/data/data_source/pet_datasource.dart';
import 'package:furever_home/features/dashboard/data/dto/get_all_pets_dto.dart';
import 'package:furever_home/features/dashboard/data/model/pet_api_model.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart'; // Import PetEntity

class PetRemoteDatasource implements IPetDataSource {
  final Dio _dio;

  PetRemoteDatasource(this._dio);

  // Fetch all pets
  @override
  Future<Either<Failure, List<PetEntity>>> getAllPets() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getAllPets);
      if (response.statusCode == 200) {
        // Parse the response into GetAllPetsDTO
        GetAllPetsDTO petAddDTO = GetAllPetsDTO.fromJson(response.data);

        // Convert PetApiModel to PetEntity and return the list
        List<PetEntity> pets = petAddDTO.data
            .map((petApiModel) =>
                petApiModel.toEntity()) // Convert each PetApiModel to PetEntity
            .toList();

        return Right(pets);
      } else {
        return Left(ApiFailure(
            message: 'Failed to fetch pets: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(message: 'DioError: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Error: ${e.toString()}'));
    }
  }

  // Fetch pet by ID
  @override
  Future<Either<Failure, PetEntity>> getPetById(String id) async {
    try {
      Response response = await _dio.get('${ApiEndpoints.getPetByID}$id');
      if (response.statusCode == 200) {
        // Convert PetApiModel to PetEntity and return it
        PetApiModel petApiModel = PetApiModel.fromJson(response.data);
        PetEntity petEntity = petApiModel.toEntity(); // Convert to PetEntity
        return Right(petEntity);
      } else {
        return Left(ApiFailure(
            message:
                'Failed to fetch pet with ID $id: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(message: 'DioError: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure(message: 'Error: ${e.toString()}'));
    }
  }
}
