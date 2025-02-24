import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/features/auth/presentation/view/sign_up_view.dart';
import 'package:furever_home/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('SignUpView', () {
    late RegisterBloc registerBloc;

    setUp(() {
      // Create a mock RegisterBloc
      registerBloc = MockRegisterBloc();
      when(() => registerBloc.state)
          .thenReturn(RegisterState(isLoading: false, isSuccess: true));
    });

    testWidgets('displays Sign Up form with initial values', (tester) async {
      // Arrange: Provide the RegisterBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: registerBloc,
            child: SignUpView(),
          ),
        ),
      );

      // Act: Verify that the form fields are populated with initial text
      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Mobile Number'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      // Check initial text field values
      expect(find.byType(TextFormField).first, findsOneWidget);
    });

    testWidgets('form validation shows errors when fields are empty',
        (tester) async {
      // Arrange: Provide the RegisterBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: registerBloc,
            child: SignUpView(),
          ),
        ),
      );

      // Act: Tap the signup button to trigger validation
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Assert: Validation errors are shown
      expect(find.text('Please enter first name'), findsOneWidget);
      expect(find.text('Please enter last name'), findsOneWidget);
      expect(find.text('Please enter phoneNo'), findsOneWidget);
      expect(find.text('Please enter email'), findsOneWidget);
      expect(find.text('Please enter password'), findsOneWidget);
    });

    testWidgets('selecting an image from gallery updates the profile image',
        (tester) async {
      // Mock the ImagePicker and PermissionHandler
      final imagePicker = MockImagePicker();
      when(() => imagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => XFile('path_to_image'));

      // Arrange: Provide the RegisterBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: registerBloc,
            child: SignUpView(),
          ),
        ),
      );

      // Act: Tap the profile image to open the bottom sheet and select gallery
      await tester.tap(find.byType(CircleAvatar));
      await tester.pumpAndSettle();

      // Tap the gallery button
      await tester.tap(find.text('Gallery'));
      await tester.pump();

      // Assert: Profile image is updated
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('Sign up button triggers RegisterStudent event',
        (tester) async {
      // Arrange: Provide the RegisterBloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: registerBloc,
            child: SignUpView(),
          ),
        ),
      );

      // Act: Fill out the form and submit
      await tester.enterText(find.byType(TextFormField).at(0), 'John');
      await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
      await tester.enterText(find.byType(TextFormField).at(2), '9876543210');
      await tester.enterText(
          find.byType(TextFormField).at(3), 'john.doe@example.com');
      await tester.enterText(
          find.byType(TextFormField).at(4), 'securepassword');

      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Assert: The RegisterStudent event should be triggered
      verify(() => registerBloc.add(RegisterStudent(
            fname: 'John',
            lname: 'Doe',
            phone: '9876543210',
            email: 'john.doe@example.com',
            password: 'securepassword',
            image: '',
            context: any(named: 'context'),
          ))).called(1);
    });
  });
}

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterBloc {}

class MockImagePicker extends Mock implements ImagePicker {}
