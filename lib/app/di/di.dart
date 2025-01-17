import 'package:furever_home/core/network/hive_service.dart';
import 'package:furever_home/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:furever_home/features/auth/domain/use_case/create_user_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/login_usecase.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:furever_home/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initRegisterDependencies() async {
  // data source
  getIt.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasource(hiveService: getIt<HiveService>()));

// repository
  getIt.registerLazySingleton<AuthLocalRepository>(() =>
      AuthLocalRepository(authLocalDataSource: getIt<AuthLocalDatasource>()));

// Use Cases
  getIt.registerLazySingleton<CreateStudentUsecase>(
      () => CreateStudentUsecase(getIt<AuthLocalRepository>()));
  // getIt.registerLazySingleton<GetAllStudentsUsecase>(
  //     () => GetAllStudentsUsecase(getIt<StudentLocalRepository>()));
  //
  // getIt.registerLazySingleton<DeleteStudentUsecase>(
  //     () => DeleteStudentUsecase(getIt<StudentLocalRepository>()));

  // RegisterBloc with student-related dependencies
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      createStudentUsecase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
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
