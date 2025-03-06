part of 'pet_bloc.dart';

// abstract class PetEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class GetAllPetsEvent extends PetEvent {}
//
// class GetPetByIdEvent extends PetEvent {
//   final String petId;
//
//   GetPetByIdEvent(this.petId);
//
//   @override
//   List<Object> get props => [petId];
// }

abstract class PetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllPetsEvent extends PetEvent {}

class NavigateToPetDetailEvent extends PetEvent {
  final PetEntity pet;

  NavigateToPetDetailEvent(this.pet);

  @override
  List<Object?> get props => [pet];
}

class SearchPetsEvent extends PetEvent {
  final String query;

  SearchPetsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
