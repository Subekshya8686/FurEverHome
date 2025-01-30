import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/app/di/di.dart';
import 'package:furever_home/core/common/snackbar/my_snackbar.dart';
import 'package:furever_home/features/auth/domain/use_case/create_user_usecase.dart';
import 'package:furever_home/features/auth/presentation/view/sign_in_view.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CreateStudentUsecase _createStudentUsecase;

  RegisterBloc({
    required CreateStudentUsecase createStudentUsecase,
  })  : _createStudentUsecase = createStudentUsecase,
        super(RegisterState.initial()) {
    // on<LoadCoursesAndBatches>(_onRegisterEvent);
    on<RegisterStudent>(_onRegisterStudent);
    on<NavigateToHomeScreenEvent>(_onNavigateToHomeScreen);
    // add(LoadCoursesAndBatches());
  }

  // void _onRegisterEvent(
  //   LoadCoursesAndBatches event,
  //   Emitter<RegisterState> emit,
  // ) {
  //   emit(state.copyWith(isLoading: true));
  //   emit(state.copyWith(isLoading: false, isSuccess: true));
  // }

  Future<void> _onRegisterStudent(
    RegisterStudent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _createStudentUsecase.call(CreateStudentParams(
      fname: event.fname,
      lname: event.lname,
      // email: event.email,
      // dateOfBirth: event.dateOfBirth,
      username: event.username,
      password: event.password,
    ));

    print(result);

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            message: "Registration Successful", context: event.context);
        print(result);

        Future.delayed(const Duration(seconds: 2), () async {
          if (event.context.mounted) {
            Navigator.pushReplacement(
              event.context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: getIt<LoginBloc>(),
                  child: LoginView(),
                ),
              ),
            );
          }
        });
      },
    );
  }

  void _onNavigateToHomeScreen(
    NavigateToHomeScreenEvent event,
    Emitter<RegisterState> emit,
  ) {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => event.destination,
      ),
    );
  }
}
