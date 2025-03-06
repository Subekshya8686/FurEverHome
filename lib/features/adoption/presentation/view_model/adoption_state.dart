// adoption_state.dart
part of 'adoption_bloc.dart';

class AdoptionState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const AdoptionState({required this.isLoading, required this.isSuccess});

  factory AdoptionState.initial() {
    return const AdoptionState(isLoading: false, isSuccess: false);
  }

  AdoptionState copyWith({bool? isLoading, bool? isSuccess}) {
    return AdoptionState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}
