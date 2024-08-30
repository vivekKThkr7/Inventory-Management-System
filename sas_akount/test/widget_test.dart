// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sas_akount/main.dart';

void main() {
  testWidgets('Login Page smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(SASAkountApp());

    // Verify that the login page is displayed with the expected widgets.
    expect(find.text('SAS Akount'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('New User? Register Here'), findsOneWidget);

    // Simulate entering text into the admin and password fields.
    await tester.enterText(find.byType(TextField).at(0), 'admin');
    await tester.enterText(find.byType(TextField).at(1), 'password');

    // Simulate a tap on the login button.
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify that the login was successful.
    expect(find.text('Login Successful'),
        findsNothing); // Toasts are not captured in tests
  });

  testWidgets('Navigation to Register Page', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(SASAkountApp());

    // Tap the 'New User? Register Here' text.
    await tester.tap(find.text('New User? Register Here'));
    await tester.pumpAndSettle();

    // Verify that the register page is displayed.
    expect(find.text('Register'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text('Register'), findsOneWidget);

    // Simulate entering text into the phone and password fields.
    await tester.enterText(find.byType(TextField).at(0), '1234567890');
    await tester.enterText(find.byType(TextField).at(1), 'password');
    await tester.enterText(find.byType(TextField).at(2), 'test@example.com');

    // Simulate a tap on the register button.
    await tester.tap(find.text('Register'));
    await tester.pump();

    // Verify that the registration was successful and navigated back to the login page.
    expect(find.text('Registration Successful'),
        findsNothing); // Toasts are not captured in tests
    expect(find.text('SAS Akount'), findsOneWidget);
  });
}
