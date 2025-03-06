import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/core/common/snackbar/my_snackbar.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/use_case/login_usecase.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:furever_home/features/home/presentation/view/home_view.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late LoginBloc loginBloc;
  late MockRegisterBloc mockRegisterBloc;
  late MockHomeCubit mockHomeCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockBuildContext mockContext; // Mock context instance

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tToken = 'fake_token';
  const tUserId = 'user123';

  final tLoginParams = LoginParams(email: tEmail, password: tPassword);

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    mockHomeCubit = MockHomeCubit();
    mockLoginUseCase = MockLoginUseCase();
    mockContext = MockBuildContext(); // Initialize mock context
    loginBloc = LoginBloc(
      registerBloc: mockRegisterBloc,
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUseCase,
    );
  });

  tearDown(() {
    loginBloc.close();
  });

  group('LoginBloc', () {
    blocTest<LoginBloc, LoginState>(
      'emits [isLoading = true, isSuccess = true] when login is successful',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Right(tToken));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginStudentEvent(
        email: tEmail,
        password: tPassword,
        context: mockContext, // Pass the mock context
      )),
      expect: () => [
        LoginState(isLoading: true, isSuccess: true),
        LoginState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(tLoginParams)).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [isLoading = true, isSuccess = false] when login fails',
      build: () {
        final failure = Failure(message: 'Invalid Credentials');
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Left(failure));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginStudentEvent(
        email: tEmail,
        password: tPassword,
        context: mockContext, // Pass the mock context
      )),
      expect: () => [
        LoginState(isLoading: true, isSuccess: true),
        LoginState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(tLoginParams)).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'navigates to home screen when login is successful',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Right(tToken));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginStudentEvent(
        email: tEmail,
        password: tPassword,
        context: mockContext, // Pass the mock context
      )),
      expect: () => [
        LoginState(isLoading: true, isSuccess: true),
        LoginState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(tLoginParams)).called(1);
        // Verify the NavigateHomeScreenEvent was added
        verify(() => loginBloc.add(NavigateHomeScreenEvent(
              context: mockContext, // Pass the mock context
              destination: HomeView(),
            ))).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'shows snackbar when login fails',
      build: () {
        final failure = Failure(message: 'Invalid Credentials');
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Left(failure));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginStudentEvent(
        email: tEmail,
        password: tPassword,
        context: mockContext, // Pass the mock context
      )),
      expect: () => [
        LoginState(isLoading: true, isSuccess: true),
        LoginState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(tLoginParams)).called(1);
        // Verify snackbar was called
        verify(() => showMySnackBar(
              context: mockContext, // Pass the mock context
              message: "Invalid Credentials",
              color: Colors.red,
            )).called(1);
      },
    );
  });
}
