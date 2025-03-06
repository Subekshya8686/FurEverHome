import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/features/auth/presentation/view/sign_in_view.dart';
import 'package:furever_home/features/onboarding/presentation/view/onboard_view.dart';
import 'package:furever_home/features/onboarding/presentation/view_model/onboarding_cubit.dart';

// Mock OnboardCubit
class MockOnboardCubit extends MockCubit<int> implements OnboardCubit {}

void main() {
  group('OnboardView', () {
    late OnboardCubit onboardCubit;

    setUp(() {
      onboardCubit = MockOnboardCubit();
    });

    testWidgets('displays onboarding pages correctly', (tester) async {
      // Setup the widget for testing
      await tester.pumpWidget(
        BlocProvider<OnboardCubit>(
          create: (_) => onboardCubit,
          child: MaterialApp(
            home: OnboardView(),
          ),
        ),
      );

      // Ensure the first page is displayed
      expect(find.text('Welcome to FurEver Home'), findsOneWidget);
      expect(
          find.text(
              'Find your new furry friend and start your journey with adoption or fostering!'),
          findsOneWidget);

      // Tap on the Next button (you may need to find the button based on the widget's structure)
      final nextButton =
          find.byType(IconButton); // Assuming IconButton is used for "Next"
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Ensure the second page is displayed after tapping "Next"
      expect(find.text('Adopt or Foster'), findsOneWidget);
      expect(
          find.text(
              'Browse profiles of pets available for adoption or fostering and make a difference in their lives.'),
          findsOneWidget);

      // Tap again to go to the next page
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Ensure the last page is displayed
      expect(find.text('Support a Pet in Need'), findsOneWidget);
      expect(
          find.text(
              'Whether it\'s a temporary foster or a forever home, you can help a pet find the care they deserve.'),
          findsOneWidget);

      // Tap to navigate to login on the last page
      final loginButton = find.byType(
          IconButton); // Again assuming the button to navigate is IconButton
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Ensure navigation to LoginView
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets('displays the correct page indicators based on current page',
        (tester) async {
      await tester.pumpWidget(
        BlocProvider<OnboardCubit>(
          create: (_) => onboardCubit,
          child: MaterialApp(
            home: OnboardView(),
          ),
        ),
      );

      // Initially, currentPage should be 0, which means the first indicator should be active
      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is AnimatedContainer &&
                widget.width == 24 &&
                widget.color == const Color(0xFF96614D),
          ),
          findsOneWidget);

      // Simulate page change to the second page
      onboardCubit.emit(1);
      await tester.pump();

      // Check if the second indicator is active
      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is AnimatedContainer &&
                widget.width == 24 &&
                widget.color == const Color(0xFF96614D),
          ),
          findsOneWidget);
    });

    testWidgets('navigates to login screen when on the last page',
        (tester) async {
      // Setup the widget for testing
      await tester.pumpWidget(
        BlocProvider<OnboardCubit>(
          create: (_) => onboardCubit,
          child: MaterialApp(
            home: OnboardView(),
          ),
        ),
      );

      // Simulate reaching the last page (page 2)
      onboardCubit.emit(2);
      await tester.pump();

      // Trigger the navigation to login
      final nextButton = find.byType(IconButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Check if LoginView is displayed after navigation
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}

extension on AnimatedContainer {
  get color => null;

  get width => null;
}
