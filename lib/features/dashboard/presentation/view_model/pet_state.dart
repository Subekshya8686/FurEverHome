part of 'pet_bloc.dart';
//
// abstract class PetState extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class PetInitialState extends PetState {}
//
// class PetLoadingState extends PetState {}
//
// class PetLoadedState extends PetState {
//   final List<PetEntity> pets;
//
//   PetLoadedState(this.pets);
//
//   @override
//   List<Object> get props => [pets];
// }
//
// class PetLoadedByIdState extends PetState {
//   final PetEntity pet;
//
//   PetLoadedByIdState(this.pet);
//
//   @override
//   List<Object> get props => [pet];
// }
//
// class PetErrorState extends PetState {
//   final String message;
//
//   PetErrorState(this.message);
//
//   @override
//   List<Object> get props => [message];
// }

abstract class PetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PetInitialState extends PetState {}

class PetLoadingState extends PetState {}

class PetLoadedState extends PetState {
  final List<PetEntity> pets;

  PetLoadedState(this.pets);

  @override
  List<Object?> get props => [pets];
}

class PetErrorState extends PetState {
  final String message;

  PetErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class PetNavigationState extends PetState {
  final PetEntity pet;

  PetNavigationState(this.pet);

  @override
  List<Object?> get props => [pet];
}
