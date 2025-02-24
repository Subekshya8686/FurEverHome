import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/core/app_theme/app_theme.dart';
import 'package:furever_home/features/splash/presentation/view/splash_view.dart';
import 'package:furever_home/features/splash/presentation/view_model/splash_cubit.dart';

// Mocking SplashCubit
class MockSplashCubit extends MockCubit<void> implements SplashCubit {}

void main() {
  late MockSplashCubit mockSplashCubit;

  setUp(() {
    mockSplashCubit = MockSplashCubit();
    // No specific state to mock, so we don't need to mock state here.
  });

  testWidgets('App widget displays SplashView when SplashCubit is provided',
      (tester) async {
    // Prepare the App widget with the mock cubit
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        // Assuming your theme function is defined properly
        home: BlocProvider.value(
          value: mockSplashCubit,
          child: const SplashView(),
        ),
      ),
    );

    // Verify if SplashView is displayed correctly
    expect(find.byType(SplashView), findsOneWidget);
  });

  testWidgets('App widget has the correct theme applied', (tester) async {
    // Prepare the App widget with the mock cubit
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        // Assuming your theme function is defined properly
        home: BlocProvider.value(
          value: mockSplashCubit,
          child: const SplashView(),
        ),
      ),
    );

    // Verify that the theme is correctly applied by checking an AppBar property
    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor,
        isNotNull); // Assuming that the theme applies a background color
  });
}
