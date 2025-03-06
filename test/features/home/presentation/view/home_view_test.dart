import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/features/home/presentation/view/home_view.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:furever_home/features/home/presentation/view_model/home_state.dart';
import 'package:mocktail/mocktail.dart';

// Mock the HomeCubit using mocktail
class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  group('HomeView Widget Tests', () {
    late MockHomeCubit mockHomeCubit;

    setUp(() {
      mockHomeCubit = MockHomeCubit();
    });

    testWidgets('HomeView displays the app bar and bottom navigation bar',
        (tester) async {
      // Set up the mock state
      when(() => mockHomeCubit.state)
          .thenReturn(HomeState(selectedIndex: 0, views: []));

      // Build the widget with the mocked HomeCubit
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>(
            create: (_) => mockHomeCubit,
            child: const HomeView(),
          ),
        ),
      );

      // Verify the AppBar is displayed
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);

      // Verify the BottomNavigationBar is displayed
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Pets'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);
    });

    testWidgets('HomeView shows logout button and triggers logout action',
        (tester) async {
      // Set up the mock state for this test
      when(() => mockHomeCubit.state)
          .thenReturn(HomeState(selectedIndex: 0, views: []));

      // Build the widget with the mocked HomeCubit
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>(
            create: (_) => mockHomeCubit,
            child: const HomeView(),
          ),
        ),
      );

      // Find the logout button and tap it
      final logoutButton = find.byIcon(Icons.logout);
      await tester.tap(logoutButton);
      await tester.pump(); // Trigger a rebuild

      // Verify that the logout action was triggered
      verify(() => mockHomeCubit.logout(any()))
          .called(1); // Verify that the logout function was called

      // Optionally verify a snackbar message or state change (if needed)
      expect(find.byIcon(Icons.logout),
          findsOneWidget); // Verifying the logout button is still there
    });
  });
}
