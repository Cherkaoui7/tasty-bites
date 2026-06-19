import 'package:flutter_test/flutter_test.dart';
import 'package:tasty_bites/main.dart';

void main() {
  testWidgets('Tasty Bites starts on the home screen', (tester) async {
    await tester.pumpWidget(const TastyBitesApp());

    expect(find.text('What would you\nlike to eat today?'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });
}
