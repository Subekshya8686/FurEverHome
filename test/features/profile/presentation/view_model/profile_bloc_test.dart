import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/app/di/di.dart';
import 'package:furever_home/core/common/snackbar/my_snackbar.dart';
import 'package:furever_home/core/error/failure.dart';
import 'package:furever_home/features/auth/domain/use_case/create_user_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:furever_home/features/auth/presentation/view/sign_in_view.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateStudentUsecase extends Mock implements CreateStudentUsecase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

class MockContext extends Mock implements BuildContext {}

void main() {
  late RegisterBloc registerBloc;
  late MockCreateStudentUsecase mockCreateStudentUsecase;
  late MockUploadImageUsecase mockUploadImageUsecase;
  late MockContext mockContext;

  setUp(() {
    mockCreateStudentUsecase = MockCreateStudentUsecase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    mockContext = MockContext();

    registerBloc = RegisterBloc(
      createStudentUsecase: mockCreateStudentUsecase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  tearDown(() {
    registerBloc.close();
  });

  group('RegisterBloc', () {
    final tFile = File('test.jpg');
    final tImageName = 'test.jpg';
    final tRegisterParams = RegisterStudent(
      fname: 'Test',
      lname: 'User',
      email: 'test@example.com',
      phone: '1234567890',
      password: 'password123',
      context: mockContext,
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading = true, isSuccess = true] when image upload is successful',
      build: () {
        when(() => mockUploadImageUsecase.call(any()))
            .thenAnswer((_) async => Right(tImageName));
        return registerBloc;
      },
      act: (bloc) => bloc.add(LoadImage(file: tFile)),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: true),
        RegisterState(isLoading: false, isSuccess: true, imageName: tImageName),
      ],
      verify: (_) {
        verify(() => mockUploadImageUsecase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading = true, isSuccess = false] when image upload fails',
      build: () {
        when(() => mockUploadImageUsecase.call(any()))
            .thenAnswer((_) async => Left(Failure(message: 'Upload failed')));
        return registerBloc;
      },
      act: (bloc) => bloc.add(LoadImage(file: tFile)),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: true),
        RegisterState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockUploadImageUsecase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading = true, isSuccess = true] when student registration is successful',
      build: () {
        when(() => mockCreateStudentUsecase.call(any()))
            .thenAnswer((_) async => Right('User Created'));
        return registerBloc;
      },
      act: (bloc) => bloc.add(tRegisterParams),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: true),
        RegisterState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockCreateStudentUsecase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading = true, isSuccess = false] when student registration fails',
      build: () {
        when(() => mockCreateStudentUsecase.call(any())).thenAnswer(
            (_) async => Left(Failure(message: 'Registration failed')));
        return registerBloc;
      },
      act: (bloc) => bloc.add(tRegisterParams),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: true),
        RegisterState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockCreateStudentUsecase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'shows snackbar when registration is successful',
      build: () {
        when(() => mockCreateStudentUsecase.call(any()))
            .thenAnswer((_) async => Right('User Created'));
        return registerBloc;
      },
      act: (bloc) => bloc.add(tRegisterParams),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: true),
        RegisterState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockCreateStudentUsecase.call(any())).called(1);
        verify(() => showMySnackBar(
              message: 'Registration Successful',
              context: mockContext,
            )).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'navigates to login view when registration is successful',
      build: () {
        when(() => mockCreateStudentUsecase.call(any()))
            .thenAnswer((_) async => Right('User Created'));
        return registerBloc;
      },
      act: (bloc) => bloc.add(tRegisterParams),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: true),
        RegisterState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockCreateStudentUsecase.call(any())).called(1);
        verify(() => Navigator.pushReplacement(
              mockContext,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: getIt<LoginBloc>(),
                  child: LoginView(),
                ),
              ),
            )).called(1);
      },
    );
  });
}
