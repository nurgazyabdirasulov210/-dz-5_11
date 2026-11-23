// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:clean_app/dependency_injection.dart';
import 'package:clean_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MainApp can be constructed', (WidgetTester tester) async {
    await initDependencies();
    await tester.pumpWidget(const MainApp());
    await tester.pump();

    expect(find.byType(MainApp), findsOneWidget);
    await sl.reset();
  });
}
