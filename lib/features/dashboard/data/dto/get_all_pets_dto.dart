import 'package:furever_home/features/dashboard/data/model/pet_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_pets_dto.g.dart';

@JsonSerializable()
class GetAllPetsDTO {
  final bool success;
  final int count;
  final List<PetApiModel> data;

  GetAllPetsDTO({
    required this.data,
    required this.success,
    required this.count,
  });

  Map<String, dynamic> toJson() => _$GetAllPetsDTOToJson(this);

  factory GetAllPetsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPetsDTOFromJson(json);
}
