part of 'profile_bloc.dart';

class UserByIdState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final AuthEntity? user;
  final String? errorMessage;
  final String? imageName;

  const UserByIdState({
    required this.isLoading,
    required this.isSuccess,
    this.user,
    this.errorMessage,
    this.imageName,
  });

  factory UserByIdState.initial() {
    return const UserByIdState(
      isLoading: false,
      isSuccess: false,
      user: null,
      errorMessage: null,
      imageName: null,
    );
  }

  UserByIdState copyWith(
      {bool? isLoading,
      bool? isSuccess,
      AuthEntity? user,
      String? errorMessage,
      String? imageName}) {
    return UserByIdState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, user, errorMessage, imageName];
}
