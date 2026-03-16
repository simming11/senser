import 'package:flutter_test/flutter_test.dart';

import 'package:senser/main.dart';

void main() {
  testWidgets('Settings screen renders expected labels', (WidgetTester tester) async {
    await tester.pumpWidget(const SenserApp());

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Other Settings'), findsOneWidget);
    expect(find.text('Profile details'), findsOneWidget);
  });
}
