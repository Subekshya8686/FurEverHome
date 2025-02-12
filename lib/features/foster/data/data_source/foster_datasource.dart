import 'package:furever_home/features/foster/domain/entity/foster_entity.dart';

abstract interface class IFosterDataSource {
  Future<void> submitFosterApplication(FosterApplicationEntity application);
}
