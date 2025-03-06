import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/adoption/domain/use_case/create_adoption_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'adoption_event.dart';
part 'adoption_state.dart';

class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  final CreateAdoptionUsecase _createAdoptionUsecase;

  AdoptionBloc({required CreateAdoptionUsecase createAdoptionUsecase})
      : _createAdoptionUsecase = createAdoptionUsecase,
        super(AdoptionState.initial()) {
    on<CreateAdoptionEvent>(_onCreateAdoptionEvent);
  }

  Future<String?> _getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> _onCreateAdoptionEvent(
    CreateAdoptionEvent event,
    Emitter<AdoptionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final userId = await _getUserID(); // Fetch the user ID

    // Proceed with the event only if the userId is not null
    if (userId != null) {
      final params = CreateAdoptionParams(
        applicantId: userId,
        // Use the fetched user ID here
        petId: event.petId,
        applicantName: event.applicantName,
        applicantEmail: event.applicantEmail,
        applicantPhone: event.applicantPhone,
        districtOrCity: event.districtOrCity,
        homeAddress: event.homeAddress,
        householdMembers: event.householdMembers,
        hasPets: event.hasPets,
        petDetails: event.petDetails,
        residenceType: event.residenceType,
        reasonForAdoption: event.reasonForAdoption,
        experienceWithPets: event.experienceWithPets,
        agreementToTerms: event.agreementToTerms,
      );
      print("params, $params");

      final result = await _createAdoptionUsecase.call(params);

      result.fold(
        (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (success) => emit(state.copyWith(isLoading: false, isSuccess: true)),
      );
    } else {
      // Handle the case when the user ID is null (e.g., show an error or handle accordingly)
      emit(state.copyWith(isLoading: false, isSuccess: false));
    }
  }
}
