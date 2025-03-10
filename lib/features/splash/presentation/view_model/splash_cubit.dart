import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furever_home/features/onboarding/presentation/view/onboard_view.dart';
import 'package:furever_home/features/onboarding/presentation/view_model/onboarding_cubit.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._loginBloc) : super(null);

  final LoginBloc _loginBloc;

  // Future<void> init(BuildContext context) async {
  //   await Future.delayed(const Duration(seconds: 5), () async {
  //     // Open Login page or Onboarding Screen
  //     if (context.mounted) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => BlocProvider.value(
  //             value: _loginBloc,
  //             child: LoginView(),
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // Open Onboarding page instead of Login page
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: OnboardCubit(_loginBloc),
              child: OnboardView(),
            ), // Navigate to Onboarding
          ),
        );
      }
    });
  }
}
