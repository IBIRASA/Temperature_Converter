import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_converter/main.dart';

void main() {
  testWidgets('Temperature conversion and history test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Enter temperature'), findsOneWidget);
    expect(find.text('Conversion History:'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '25');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('25 °C = 77.00 °F'), findsOneWidget);
    expect(find.text('Conversion History:'), findsOneWidget);
    expect(find.text('25 °C = 77.00 °F'), findsNWidgets(2));

    await tester.enterText(find.byType(TextField), '100');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('100 °C = 212.00 °F'), findsOneWidget);
    expect(find.text('Conversion History:'), findsOneWidget);
    expect(find.text('100 °C = 212.00 °F'), findsOneWidget);
    expect(find.text('25 °C = 77.00 °F'), findsOneWidget);
  });
}
