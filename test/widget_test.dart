// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_coding/main.dart';

void main() {
  testWidgets('Go button behavior', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    var addressFinder = find.byWidgetPredicate(
      (w) => w is TextField && w.decoration.hintText == 'Address',
    );
    var goButton = 'Go';
    var locationButton = 'My location';

    expect(addressFinder, findsOneWidget);

    // Verify that the Go button is disabled
    expect(_findButton(goButton, disabled: true), findsOneWidget);
    expect(_findButton(locationButton), findsOneWidget);

    // Enter some text in the address field
    await tester.enterText(addressFinder, 'London');
    await tester.pump();

    // Verify that the Go button is enabled
    expect(_findButton(goButton), findsOneWidget);
    expect(_findButton(locationButton), findsOneWidget);
  });
}

Finder _findButton(String label, {bool disabled = false}) {
  return find.byWidgetPredicate((w) {
    return w is RaisedButton &&
        (w.child as Text).data == label &&
        (disabled || w.onPressed != null);
  });
}
