import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/app/di/di.dart';
import 'package:furever_home/core/app_theme/app_theme.dart';
import 'package:furever_home/features/splash/presentation/view/splash_view.dart';
import 'package:furever_home/features/splash/presentation/view_model/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FurEver Home',
      // theme: AppTheme.getApplicationTheme(isDarkMode: false),
      theme: getApplicationTheme(),
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: const SplashView(),
      ),
    );
  }
}
