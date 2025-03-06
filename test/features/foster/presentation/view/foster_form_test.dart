import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/foster/domain/use_case/create_foster_usecase.dart';
import 'package:furever_home/features/foster/presentation/view/foster_form.dart';
import 'package:furever_home/features/foster/presentation/view_model/foster_bloc.dart';
import 'package:mockito/mockito.dart';

class MockCreateFosterUseCase extends Mock implements CreateFosterUseCase {
  createFoster(any) {}
}

void main() {
  group('FosterFormPage Widget Test', () {
    late PetEntity petEntity;
    late MockCreateFosterUseCase mockCreateFosterUseCase;

    setUp(() {
      petEntity = PetEntity(
        id: 'pet123',
        name: 'Buddy',
        description: 'Friendly dog',
        type: 'Dog',
        breed: 'Labrador',
        age: 3,
        weight: 20.0,
        vaccinated: true,
        specialNeeds: false,
        healthDetails: 'Healthy',
        height: 1.0,
        furType: 'Short',
        color: 'Yellow',
        eyeColor: 'Brown',
        dateOfBirth: DateTime(2020, 01, 01),
        dateAdded: DateTime.now(),
        adoptionStatus: 'Available',
        bookmarkedBy: ['user123'],
        photo: 'buddy.jpg',
      );

      mockCreateFosterUseCase = MockCreateFosterUseCase();
    });

    testWidgets('Renders the Foster Form Page and submits',
        (WidgetTester tester) async {
      // Setup the widget tree
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) =>
                FosterFormBloc(createFosterUseCase: mockCreateFosterUseCase),
            child: FosterFormPage(pet: petEntity),
          ),
        ),
      );

      // Verify the page renders the pet's info
      expect(find.text('Pet Name: Buddy'), findsOneWidget);
      expect(find.text('Breed: Labrador'), findsOneWidget);
      expect(find.text('Age: 3 years'), findsOneWidget);

      // Verify the text fields are present
      expect(
          find.byType(TextFormField), findsNWidgets(11)); // 11 fields in total

      // Fill in form fields
      await tester.enterText(
          find.byType(TextFormField).at(0), 'John Doe'); // Applicant Name
      await tester.enterText(find.byType(TextFormField).at(1),
          'john.doe@example.com'); // Applicant Email
      await tester.enterText(
          find.byType(TextFormField).at(2), '1234567890'); // Applicant Phone
      await tester.enterText(
          find.byType(TextFormField).at(3), 'New York'); // District/City
      await tester.enterText(
          find.byType(TextFormField).at(4), '123 Main St'); // Home Address
      await tester.enterText(
          find.byType(TextFormField).at(5), '4'); // Household Members
      await tester.enterText(find.byType(TextFormField).at(6),
          'Friendly and playful dog'); // Pet Details
      await tester.enterText(
          find.byType(TextFormField).at(7), 'Apartment'); // Residence Type
      await tester.enterText(find.byType(TextFormField).at(8),
          'Looking for a pet companion'); // Reason for Fostering
      await tester.enterText(find.byType(TextFormField).at(9),
          'Yes, I have experience'); // Experience with Pets
      await tester.enterText(find.byType(TextFormField).at(10),
          'Short-term'); // Availability Duration

      // Agree to the terms
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pump();

      // Tap the submit button
      await tester.tap(find.text('Submit Form'));
      await tester.pump(); // Wait for the async operation to complete

      // Verify that the form submission action was called
      verify(mockCreateFosterUseCase.createFoster(any)).called(1);

      // Check that the success message is displayed
      expect(find.text('Foster form submitted successfully!'), findsOneWidget);
    });
  });
}
