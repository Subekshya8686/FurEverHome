part of 'foster_bloc.dart';

class FosterFormState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  FosterFormState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
  });

  // Initial state with default values
  FosterFormState.initial()
      : isLoading = false,
        isSuccess = false,
        errorMessage = null;

  // Method to copy the state with updated values
  FosterFormState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    String? errorMessage,
  }) {
    return FosterFormState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // List of props for comparison (used in Equatable for efficient state comparison)
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
