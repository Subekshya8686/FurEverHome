import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/app/di/di.dart';
import 'package:furever_home/app/shared_prefs/token_shared_prefs.dart';
import 'package:furever_home/features/adoption/presentation/view/adoption_form.dart';
import 'package:furever_home/features/adoption/presentation/view_model/adoption_bloc.dart';
import 'package:furever_home/features/auth/presentation/view/sign_in_view.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/presentation/view/pet_detail_screen.dart';
import 'package:furever_home/features/dashboard/presentation/view/pet_home_screen.dart';
import 'package:furever_home/features/dashboard/presentation/view_model/pet_bloc.dart';
import 'package:furever_home/features/foster/presentation/view/foster_form.dart';
import 'package:furever_home/features/foster/presentation/view_model/foster_bloc.dart';
import 'package:furever_home/features/home/presentation/view_model/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void showPetDetails(PetEntity pet) {
    // Replace the pets tab with PetDetailScreen
    final updatedViews = [...state.views];
    updatedViews[0] = PetDetailScreen(pet: pet);
    emit(state.copyWith(views: updatedViews, selectedIndex: 0));
  }

  void petFosterScreen(PetEntity pet) {
    // Replace the pets tab with PetDetailScreen
    final updatedViews = [...state.views];
    updatedViews[0] = BlocProvider(
      create: (context) => getIt<FosterFormBloc>(),
      child: FosterFormPage(pet: pet),
    );
    emit(state.copyWith(views: updatedViews, selectedIndex: 0));
  }

  void petAdoptionScreen(PetEntity pet) {
    // Replace the pets tab with PetDetailScreen
    final updatedViews = [...state.views];
    updatedViews[0] = BlocProvider(
      create: (context) => getIt<AdoptionBloc>(),
      child: AdoptionFormPage(pet: pet),
    );
    emit(state.copyWith(views: updatedViews, selectedIndex: 0));
  }

  void goBackToPetList() {
    final updatedViews = [...state.views];
    updatedViews[0] = BlocProvider(
      create: (context) => getIt<PetBloc>(),
      child: const PetHomeScreen(),
    );
    emit(state.copyWith(views: updatedViews, selectedIndex: 0));
  }

  void logout(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      // Clear stored token and user data
      final tokenPrefs =
          TokenSharedPrefs(await SharedPreferences.getInstance());
      await tokenPrefs.clearTokenAndUserId();

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}
