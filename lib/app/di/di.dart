import 'package:dio/dio.dart';
import 'package:furever_home/app/shared_prefs/token_shared_prefs.dart';
import 'package:furever_home/core/network/api_service.dart';
import 'package:furever_home/core/network/hive_service.dart';
import 'package:furever_home/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:furever_home/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:furever_home/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/create_user_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/login_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:furever_home/features/dashboard/data/data_source/pet_remote_datasource/pet_remote_datasource.dart';
import 'package:furever_home/features/dashboard/data/repository/pet_remote_repository.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_all_pets_usecase.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:furever_home/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();

  await _initPetDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initRegisterDependencies() async {
  // data source ===============================================
  getIt.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<Dio>()),
  );

// repository ===============================================
  getIt.registerLazySingleton<AuthLocalRepository>(() =>
      AuthLocalRepository(authLocalDataSource: getIt<AuthLocalDatasource>()));

  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
  );

// Use Cases ===============================================
//   getIt.registerLazySingleton<CreateStudentUsecase>(
//       () => CreateStudentUsecase(getIt<AuthLocalRepository>()));

  getIt.registerLazySingleton<CreateStudentUsecase>(
    () => CreateStudentUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // getIt.registerLazySingleton<GetAllStudentsUsecase>(
  //     () => GetAllStudentsUsecase(getIt<StudentLocalRepository>()));
  //
  // getIt.registerLazySingleton<DeleteStudentUsecase>(
  //     () => DeleteStudentUsecase(getIt<StudentLocalRepository>()));

  // RegisterBloc with student-related dependencies
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      createStudentUsecase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initPetDependencies() async {
  // data source ===============================================
  getIt.registerLazySingleton<PetRemoteDatasource>(
    () => PetRemoteDatasource(getIt<Dio>()),
  );

// repository ===============================================
  getIt.registerLazySingleton<PetRemoteRepository>(
    () => PetRemoteRepository(getIt<PetRemoteDatasource>()),
  );

// Use Cases ===============================================
  getIt.registerLazySingleton<GetAllPetsUseCase>(
    () => GetAllPetsUseCase(repository: getIt<PetRemoteRepository>()),
  );
}

_initLoginDependencies() async {
  // getIt.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}

// _initOnboardingScreenDependencies() async {
//   getIt.registerFactory<OnboardCubit>(
//     () => OnboardCubit(getIt<LoginBloc>()),
//   );
// }
