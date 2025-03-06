import 'package:furever_home/features/auth/data/model/auth_hive_model.dart';
import 'package:furever_home/features/dashboard/data/model/pet_hive_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}subekshya_furever_home.db';

    Hive.init(path);

    // Hive.registerAdapter(BatchHiveModelAdapter());
    // Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(PetModelAdapter());
  }

  // Auth Queries
  Future<void> addAuth(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.put(auth.studentId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    return box.values.toList();
  }

  Future<AuthHiveModel?> loginStudent(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    var auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    // orElse: () => AuthHiveModel.initial());
    return auth;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.authBox);
  }

  // ===========================
  // PET QUERIES
  // ===========================
  Future<List<PetModel>> getAllPets() async {
    var box = await Hive.openBox<PetModel>(HiveTableConstant.petBox);
    return box.values.toList();
  }

  Future<PetModel?> getPetById(String id) async {
    var box = await Hive.openBox<PetModel>(HiveTableConstant.petBox);
    return box.get(id);
  }

  Future<void> clearAllPets() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.petBox);
  }

  // ===========================
  // CLOSE
  // ===========================

  Future<void> close() async {
    await Hive.close();
  }
}
