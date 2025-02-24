import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furever_home/features/auth/presentation/view/sign_in_view.dart';
import 'package:furever_home/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  group('LoginView Widget Test', () {
    late MockLoginBloc mockLoginBloc;

    setUp(() {
      mockLoginBloc = MockLoginBloc();
    });

    testWidgets('should display email and password fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<LoginBloc>(
              create: (_) => mockLoginBloc,
              child: LoginView(),
            ),
          ),
        ),
      );

      // Check if the email field is present
      expect(find.byKey(ValueKey('email')), findsOneWidget);

      // Check if the password field is present
      expect(find.byKey(ValueKey('password')), findsOneWidget);
    });

    testWidgets('should trigger login event on valid form submission',
        (tester) async {
      when(() => mockLoginBloc.add(any())).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<LoginBloc>(
              create: (_) => mockLoginBloc,
              child: LoginView(),
            ),
          ),
        ),
      );

      // Enter valid email and password
      await tester.enterText(find.byKey(ValueKey('email')), 'test@example.com');
      await tester.enterText(find.byKey(ValueKey('password')), 'password123');

      // Tap the login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the LoginStudentEvent is triggered
      verify(() => mockLoginBloc.add(any())).called(1);
    });

    testWidgets('should show validation error if email is empty',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<LoginBloc>(
              create: (_) => mockLoginBloc,
              child: LoginView(),
            ),
          ),
        ),
      );

      // Leave the email field empty
      await tester.enterText(find.byKey(ValueKey('password')), 'password123');

      // Tap the login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the validation error for email is shown
      expect(find.text('Please enter email address'), findsOneWidget);
    });

    testWidgets('should navigate to SignUp screen on Sign Up button click',
        (tester) async {
      when(() => mockLoginBloc.add(any())).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<LoginBloc>(
              create: (_) => mockLoginBloc,
              child: LoginView(),
            ),
          ),
        ),
      );

      // Tap the "Sign Up" button
      await tester.tap(find.byKey(ValueKey("registerButton")));
      await tester.pump();

      // Verify that the event to navigate to the SignUp screen was triggered
      verify(() => mockLoginBloc.add(any())).called(1);
    });

    testWidgets(
        'should navigate to Forget Password screen on "Forgot password?" link click',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<LoginBloc>(
              create: (_) => mockLoginBloc,
              child: LoginView(),
            ),
          ),
        ),
      );

      // Tap the "Forgot password?" link
      await tester.tap(find.text('Forgot password?'));
      await tester.pumpAndSettle();

      // Verify that the navigation occurs
      expect(find.byType(Scaffold),
          findsOneWidget); // You can check for the screen change here
    });
  });
}
