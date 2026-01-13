import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madrasati_app/main.dart';

void main() {
  testWidgets('Login screen UI elements are displayed',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify login screen elements
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('User enters email and password',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Enter email
    await tester.enterText(
        find.byKey(const Key('emailField')),
        'test@student.com');

    // Enter password
    await tester.enterText(
        find.byKey(const Key('passwordField')),
        '123456');

    // Verify input
    expect(find.text('test@student.com'), findsOneWidget);
    expect(find.text('123456'), findsOneWidget);
  });
}
