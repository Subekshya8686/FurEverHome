import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/foster/domain/use_case/create_foster_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'foster_event.dart';
part 'foster_state.dart';

class FosterFormBloc extends Bloc<FosterFormEvent, FosterFormState> {
  final CreateFosterUseCase _createFosterUseCase;

  FosterFormBloc({
    required CreateFosterUseCase createFosterUseCase,
  })  : _createFosterUseCase = createFosterUseCase,
        super(FosterFormState.initial()) {
    on<SubmitFormEvent>(_onSubmitFormEvent);
  }

  Future<String?> _getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Event for submitting the foster form
  Future<void> _onSubmitFormEvent(
    SubmitFormEvent event,
    Emitter<FosterFormState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final userId = await _getUserID();

    final params = CreateFosterParams(
      applicantId: userId!,
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
      reasonForFostering: event.reasonForFostering,
      experienceWithPets: event.experienceWithPets,
      availabilityDuration: event.availabilityDuration,
      abilityToHandleMedicalNeeds: event.abilityToHandleMedicalNeeds,
      hasFencedYard: event.hasFencedYard,
      agreementToTerms: event.agreementToTerms,
    );

    print(params);
    final result = await _createFosterUseCase.call(params);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }
}
