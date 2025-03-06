import 'package:furever_home/features/adoption/domain/entity/adoption_entity.dart';

abstract interface class IAdoptionDatasource {
  Future<void> createAdoption(AdoptionEntity adoption);
}
