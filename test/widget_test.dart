import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:local_marketblace/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('App uses configured theme', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify the app is using Material 3
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.theme?.useMaterial3, true);
    expect(materialApp.darkTheme?.useMaterial3, true);
  });
}
