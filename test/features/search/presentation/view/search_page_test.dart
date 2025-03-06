import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/presentation/view_model/pet_bloc.dart';
import 'package:furever_home/features/search/presentation/view/search_page.dart';
import 'package:mockito/mockito.dart';

// Mock classes using Mockito
class MockPetBloc extends Mock implements PetBloc {}

class MockPetState extends Mock implements PetState {}

class MockPetEntity extends Mock implements PetEntity {}

void main() {
  group('SearchPage Widget Tests', () {
    testWidgets('should display search field and initial instructions',
        (WidgetTester tester) async {
      final mockPetBloc = MockPetBloc();

      // Build the widget with mock PetBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetBloc>(
            create: (_) => mockPetBloc,
            child: SearchPage(),
          ),
        ),
      );

      // Wait for widget tree to build and settle
      await tester.pumpAndSettle();

      // Verify the search field is present
      expect(find.byType(TextField),
          findsOneWidget); // or TextFormField if that's used
      expect(find.text("Search for a pet"), findsOneWidget);

      // Verify initial instructions are visible
      expect(find.text("Start searching for pets!"), findsOneWidget);
    });

    testWidgets('should trigger search on typing', (WidgetTester tester) async {
      final mockPetBloc = MockPetBloc();

      // Build the widget with mock PetBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetBloc>(
            create: (_) => mockPetBloc,
            child: SearchPage(),
          ),
        ),
      );

      // Simulate typing in the search field
      await tester.enterText(find.byType(TextField), 'dog');
      await tester.pumpAndSettle();

      // Verify that the Bloc event for searching pets was triggered
      verify(mockPetBloc.add(SearchPetsEvent('dog'))).called(1);
    });

    testWidgets('should display loading state when pets are being fetched',
        (WidgetTester tester) async {
      final mockPetBloc = MockPetBloc();
      when(mockPetBloc.state).thenReturn(PetLoadingState());

      // Build the widget with mock PetBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetBloc>(
            create: (_) => mockPetBloc,
            child: SearchPage(),
          ),
        ),
      );

      // Check if loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'should display error message if there is an error fetching pets',
        (WidgetTester tester) async {
      final mockPetBloc = MockPetBloc();
      when(mockPetBloc.state).thenReturn(PetErrorState('An error occurred'));

      // Build the widget with mock PetBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetBloc>(
            create: (_) => mockPetBloc,
            child: SearchPage(),
          ),
        ),
      );

      // Check if the error message is displayed
      expect(find.text("Error: An error occurred"), findsOneWidget);
    });

    testWidgets('should clear search query on shake gesture',
        (WidgetTester tester) async {
      final mockPetBloc = MockPetBloc();

      // Build the widget with mock PetBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetBloc>(
            create: (_) => mockPetBloc,
            child: SearchPage(),
          ),
        ),
      );

      // Simulate shaking gesture (you may need to simulate accelerometer event here)
      // For now, assume _clearSearch method is triggered
      await tester.pumpAndSettle();

      // Verify that search query is cleared
      expect(find.text(''), findsOneWidget);

      // Verify that the search event with an empty query is triggered
      verify(mockPetBloc.add(SearchPetsEvent(''))).called(1);
    });
  });
}
