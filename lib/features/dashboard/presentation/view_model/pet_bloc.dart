import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_all_pets_usecase.dart';
import 'package:furever_home/features/dashboard/domain/use_case/get_pet_by_id_usecase.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final GetAllPetsUseCase _getAllPetsUseCase;
  final GetPetByIdUseCase _getPetByIdUseCase;

  List<PetEntity> allPets = []; // Store all pets

  PetBloc({
    required GetAllPetsUseCase getAllPetsUseCase,
    required GetPetByIdUseCase getPetByIdUseCase,
  })  : _getAllPetsUseCase = getAllPetsUseCase,
        _getPetByIdUseCase = getPetByIdUseCase,
        super(PetInitialState()) {
    on<GetAllPetsEvent>(_onGetAllPetsEvent);
    on<SearchPetsEvent>(_onSearchPetsEvent);
    on<NavigateToPetDetailEvent>(_navigateToPetDetail);
  }

  Future<void> _onGetAllPetsEvent(
    GetAllPetsEvent event,
    Emitter<PetState> emit,
  ) async {
    emit(PetLoadingState());
    final result = await _getAllPetsUseCase();

    result.fold(
      (failure) => emit(PetErrorState(failure.message)),
      (pets) {
        allPets = pets; // Store full list for filtering
        emit(PetLoadedState(pets));
      },
    );
  }

  void _onSearchPetsEvent(
    SearchPetsEvent event,
    Emitter<PetState> emit,
  ) {
    final filteredPets = allPets.where((pet) {
      final query = event.query.toLowerCase();
      return pet.name.toLowerCase().contains(query) ||
          pet.type.toLowerCase().contains(query);
    }).toList();

    emit(PetLoadedState(filteredPets));
  }

  void _navigateToPetDetail(
      NavigateToPetDetailEvent event, Emitter<PetState> emit) {
    emit(PetNavigationState(event.pet));
  }
}
