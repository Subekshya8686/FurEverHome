import 'package:dio/dio.dart';
import 'package:furever_home/app/shared_prefs/token_shared_prefs.dart';
import 'package:furever_home/core/network/api_service.dart';
import 'package:furever_home/core/network/hive_service.dart';
import 'package:furever_home/features/adoption/data/data_source/adoption_remote_datasource/adoption_remote_datasource.dart';
import 'package:furever_home/features/adoption/data/repository/adoption_remote_repository.dart';
import 'package:furever_home/features/adoption/domain/use_case/create_adoption_usecase.dart';
import 'package:furever_home/features/adoption/presentation/view_model/adoption_bloc.dart';
import 'package:furever_home/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:furever_home/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:furever_home/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/create_user_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/get_user_by_id_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/login_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/update_user_by_id_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:furever_home/features/dashboard/data/data_source/pet_remote_datasource/pet_remote_datasource.dart';
import 'package:furever_home/features/dashboard/data/repository/pet_remote_repository.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_all_pets_usecase.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_pet_by_id_usecase.dart';
import 'package:furever_home/features/dashboard/presentation/view_model/pet_bloc.dart';
import 'package:furever_home/features/foster/data/data_source/foster_remote_datasource.dart';
import 'package:furever_home/features/foster/data/repository/foster_remote_repository.dart';
import 'package:furever_home/features/foster/domain/use_case/create_foster_usecase.dart';
import 'package:furever_home/features/foster/presentation/view_model/foster_bloc.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:furever_home/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:furever_home/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:furever_home/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();

  await _initPetDependencies();
  await _initAdoptionDependencies();
  await _initFosterDependencies();
  await _initOnboardingScreenDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
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

  getIt.registerLazySingleton<GetUserByIdUseCase>(
    () => GetUserByIdUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<UpdateStudentByIdUseCase>(
    () => UpdateStudentByIdUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<UserByIdBloc>(
    () => UserByIdBloc(
      getUserByIdUseCase: getIt(),
      updateUserByIdUseCase: getIt(),
      uploadImageUsecase: getIt(),
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

  getIt.registerLazySingleton<GetPetByIdUseCase>(
    () => GetPetByIdUseCase(getIt<PetRemoteRepository>()),
  );

  // Register PetBloc ==========================================
  getIt.registerFactory<PetBloc>(
    () => PetBloc(
      getAllPetsUseCase: getIt<GetAllPetsUseCase>(),
      getPetByIdUseCase: getIt<GetPetByIdUseCase>(),
    ),
  );
}

_initAdoptionDependencies() async {
  // data source ===============================================
  getIt.registerLazySingleton<AdoptionRemoteDatasource>(
    () => AdoptionRemoteDatasource(getIt<Dio>()),
  );

// repository ===============================================
  getIt.registerLazySingleton<AdoptionRepository>(
    () => AdoptionRepository(getIt<AdoptionRemoteDatasource>()),
  );

// Use Cases ===============================================
  getIt.registerLazySingleton<CreateAdoptionUsecase>(
    () => CreateAdoptionUsecase(getIt<AdoptionRepository>()),
  );

  // Register PetBloc ==========================================
  getIt.registerFactory<AdoptionBloc>(
    () => AdoptionBloc(
      createAdoptionUsecase: getIt<CreateAdoptionUsecase>(),
    ),
  );
}

_initFosterDependencies() async {
  // data source ===============================================
  getIt.registerLazySingleton<FosterRemoteDatasource>(
    () => FosterRemoteDatasource(getIt<Dio>()),
  );

// repository ===============================================
  getIt.registerLazySingleton<FosterRepository>(
    () => FosterRepository(getIt<FosterRemoteDatasource>()),
  );

// Use Cases ===============================================
  getIt.registerLazySingleton<CreateFosterUseCase>(
    () => CreateFosterUseCase(getIt<FosterRepository>()),
  );

  // Register PetBloc ==========================================
  getIt.registerFactory<FosterFormBloc>(
    () => FosterFormBloc(
      createFosterUseCase: getIt<CreateFosterUseCase>(),
    ),
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

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardCubit>(
    () => OnboardCubit(getIt<LoginBloc>()),
  );
}
