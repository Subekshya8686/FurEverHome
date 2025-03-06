import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:furever_home/features/auth/domain/use_case/get_user_by_id_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/update_user_by_id_usecase.dart';
import 'package:furever_home/features/auth/domain/use_case/upload_image_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class UserByIdBloc extends Bloc<UserByIdEvent, UserByIdState> {
  final GetUserByIdUseCase _getUserByIdUseCase;
  final UpdateStudentByIdUseCase _updateUserByIdUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  UserByIdBloc({
    required GetUserByIdUseCase getUserByIdUseCase,
    required UpdateStudentByIdUseCase updateUserByIdUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _getUserByIdUseCase = getUserByIdUseCase,
        _updateUserByIdUseCase = updateUserByIdUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(UserByIdState.initial()) {
    on<GetUserByIdEvent>(_onGetUserById);
    on<UpdateUserByIdEvent>(_onUpdateUserById);
    on<LoadImage>(_onLoadImage);
    on<NavigateToProfilePageEvent>(_onNavigateToProfilePage);
  }

  void _onLoadImage(
    LoadImage event,
    Emitter<UserByIdState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: event.file),
    );

    print("$result, Image");

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: false, imageName: r));
    });
  }

  Future<void> _onGetUserById(
    GetUserByIdEvent event,
    Emitter<UserByIdState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getUserByIdUseCase.call(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, user: null, errorMessage: failure.message)),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
  }

  Future<void> _onUpdateUserById(
    UpdateUserByIdEvent event,
    Emitter<UserByIdState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await _updateUserByIdUseCase.call(event.id, event.updatedUser);

    print(result);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        // ScaffoldMessenger.of(event.context).showSnackBar(
        //   const SnackBar(content: Text("Profile updated successfully!")),
        // );
      },
    );
  }

  void _onNavigateToProfilePage(
    NavigateToProfilePageEvent event,
    Emitter<UserByIdState> emit,
  ) {
    // Pop the current page off the stack to go back to the previous page
    Navigator.pop(event.context);

    // Trigger a reload or refresh action to update the ProfileView
    // Now that we have the 'id' in the NavigateToProfilePageEvent, we can pass it
    BlocProvider.of<UserByIdBloc>(event.context).add(
      GetUserByIdEvent(event.id), // Pass the id here from the event
    );
  }
}
