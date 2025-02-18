import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/auth/presentation/view/sign_in_view.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';

class OnboardCubit extends Cubit<int> {
  OnboardCubit(this._loginBloc) : super(0);

  final LoginBloc _loginBloc;
  final PageController pageController = PageController();

  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _loginBloc, // Provide the LoginBloc
          child: LoginView(),
        ),
      ),
    );
  }

  void goToNextPage() {
    if (state < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(state + 1);
    }
  }

  void onPageChanged(int index) {
    emit(index);
  }
}
