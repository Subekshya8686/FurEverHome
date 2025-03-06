import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/presentation/view/pet_home_screen.dart';
import 'package:furever_home/features/dashboard/presentation/view_model/pet_bloc.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:furever_home/features/home/presentation/view_model/home_state.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockPetBloc extends MockBloc<PetEvent, PetState> implements PetBloc {}

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  group('PetHomeScreen', () {
    late MockPetBloc petBloc;
    late MockHomeCubit homeCubit;

    setUp(() {
      petBloc = MockPetBloc();
      homeCubit = MockHomeCubit();
    });

    testWidgets('displays loading state when PetBloc is loading',
        (tester) async {
      // Arrange
      when(() => petBloc.state).thenReturn(PetLoadingState());

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetBloc>(
            create: (_) => petBloc,
            child: PetHomeScreen(),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message when PetBloc encounters error',
        (tester) async {
      // Arrange
      when(() => petBloc.state).thenReturn(PetErrorState('Error loading pets'));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetBloc>(
            create: (_) => petBloc,
            child: PetHomeScreen(),
          ),
        ),
      );

      // Assert
      expect(find.text('Error: Error loading pets'), findsOneWidget);
    });

    testWidgets('displays list of pets when PetBloc is loaded', (tester) async {
      // Arrange
      final pets = [
        PetEntity(
            id: '1',
            name: 'Buddy',
            description: 'A friendly dog',
            type: 'Dog',
            breed: 'Golden Retriever',
            age: 3,
            weight: 25.0,
            vaccinated: true,
            specialNeeds: false,
            photo: 'dog1.jpg'),
        PetEntity(
            id: '2',
            name: 'Max',
            description: 'A playful puppy',
            type: 'Dog',
            breed: 'Labrador',
            age: 2,
            weight: 20.0,
            vaccinated: true,
            specialNeeds: false,
            photo: 'dog2.jpg'),
      ];
      when(() => petBloc.state).thenReturn(PetLoadedState(pets));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PetBloc>(
            create: (_) => petBloc,
            child: PetHomeScreen(),
          ),
        ),
      );

      // Assert
      expect(find.byType(PetCard), findsNWidgets(2));
      expect(find.text('Buddy'), findsOneWidget);
      expect(find.text('Max'), findsOneWidget);
    });
  });

  group('PetCard', () {
    testWidgets('displays pet information correctly', (tester) async {
      // Arrange
      final pet = PetEntity(
          id: '1',
          name: 'Buddy',
          description: 'A friendly dog',
          type: 'Dog',
          breed: 'Golden Retriever',
          age: 3,
          weight: 25.0,
          vaccinated: true,
          specialNeeds: false,
          photo: 'dog1.jpg');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>(
            create: (_) => MockHomeCubit(),
            child: PetCard(pet: pet),
          ),
        ),
      );

      // Assert
      expect(find.text('Buddy'), findsOneWidget);
      expect(find.text('3 years old'), findsOneWidget);
      expect(find.text('A friendly dog'), findsOneWidget);
    });

    testWidgets('navigates to pet details when tapped', (tester) async {
      // Arrange
      final pet = PetEntity(
          id: '1',
          name: 'Buddy',
          description: 'A friendly dog',
          type: 'Dog',
          breed: 'Golden Retriever',
          age: 3,
          weight: 25.0,
          vaccinated: true,
          specialNeeds: false,
          photo: 'dog1.jpg');
      final mockHomeCubit = MockHomeCubit();
      when(() => mockHomeCubit.showPetDetails(pet)).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeCubit>(
            create: (_) => mockHomeCubit,
            child: PetCard(pet: pet),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(GestureDetector));

      // Assert
      verify(() => mockHomeCubit.showPetDetails(pet)).called(1);
    });
  });
}
