import 'package:furever_home/core/network/hive_service.dart';
import 'package:furever_home/features/auth/data/data_source/local_datasource/student_local_datasource.dart';
import 'package:furever_home/features/auth/data/repository/student_local_repository/student_local_repository.dart';
import 'package:furever_home/features/auth/domain/use_case/create_student_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/login_usecase.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:furever_home/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:furever_home/features/batch/data/repository/batch_local_repository/batch_local_repository.dart';
import 'package:furever_home/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:furever_home/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:furever_home/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:furever_home/features/batch/presentation/view_model/batch_bloc.dart';
import 'package:furever_home/features/course/data/data_source/local_datasource/course_local_datasource.dart';
import 'package:furever_home/features/course/data/repository/course_local_repository.dart';
import 'package:furever_home/features/course/domain/use_case/create_course_usecase.dart';
import 'package:furever_home/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:furever_home/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:furever_home/features/course/presentation/view_model/bloc/course_bloc.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:furever_home/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initBatchDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initCourseDependencies();
  // await _initOnboardingScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initBatchDependencies() async {
  // data source
  getIt.registerLazySingleton<BatchLocalDataSource>(
      () => BatchLocalDataSource(hiveService: getIt<HiveService>()));

// repository
  getIt.registerLazySingleton<BatchLocalRepository>(
      () => BatchLocalRepository(batchLocalDataSource: getIt()));

// usecases
  getIt.registerLazySingleton<CreateBatchUsecase>(
      () => CreateBatchUsecase(getIt<BatchLocalRepository>()));

  getIt.registerLazySingleton<GetAllBatchUsecase>(() => GetAllBatchUsecase(
        repository: getIt<BatchLocalRepository>(),
      ));

  getIt.registerLazySingleton<DeleteBatchUsecase>(() => DeleteBatchUsecase(
        repository: getIt<BatchLocalRepository>(),
      ));

  getIt.registerFactory<BatchBloc>(
    () => BatchBloc(
      createBatchUsecase: getIt<CreateBatchUsecase>(),
      getAllBatchUsecase: getIt<GetAllBatchUsecase>(),
      deleteBatchUsecase: getIt<DeleteBatchUsecase>(),
    ),
  );
}

_initCourseDependencies() async {
  // data source
  getIt.registerLazySingleton<CourseLocalDatasource>(
      () => CourseLocalDatasource(hiveService: getIt<HiveService>()));

// repository
  getIt.registerLazySingleton<CourseLocalRepository>(
      () => CourseLocalRepository(courseLocalDatasource: getIt()));

// usecases
  getIt.registerLazySingleton<CreateCourseUsecase>(() =>
      CreateCourseUsecase(courseRepository: getIt<CourseLocalRepository>()));

  getIt.registerLazySingleton<GetAllCourseUsecase>(() => GetAllCourseUsecase(
        repository: getIt<CourseLocalRepository>(),
      ));

  getIt.registerLazySingleton<DeleteCourseUsecase>(() => DeleteCourseUsecase(
        repository: getIt<CourseLocalRepository>(),
      ));

  getIt.registerFactory<CourseBloc>(
    () => CourseBloc(
      createCourseUsecase: getIt<CreateCourseUsecase>(),
      getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
      deleteCourseUsecase: getIt<DeleteCourseUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initRegisterDependencies() async {
  // data source
  getIt.registerLazySingleton<StudentLocalDatasource>(
      () => StudentLocalDatasource(hiveService: getIt<HiveService>()));

// repository
  getIt.registerLazySingleton<StudentLocalRepository>(() =>
      StudentLocalRepository(
          studentLocalDataSource: getIt<StudentLocalDatasource>()));

// Use Cases
  getIt.registerLazySingleton<CreateStudentUsecase>(
      () => CreateStudentUsecase(getIt<StudentLocalRepository>()));
  // getIt.registerLazySingleton<GetAllStudentsUsecase>(
  //     () => GetAllStudentsUsecase(getIt<StudentLocalRepository>()));
  //
  // getIt.registerLazySingleton<DeleteStudentUsecase>(
  //     () => DeleteStudentUsecase(getIt<StudentLocalRepository>()));

  // RegisterBloc with student-related dependencies
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      batchBloc: getIt<BatchBloc>(),
      courseBloc: getIt<CourseBloc>(),
      createStudentUsecase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<StudentLocalRepository>(),
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
