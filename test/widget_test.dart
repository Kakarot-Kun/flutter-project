
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chronometre/main.dart';

void main() {
  testWidgets('Le chronomètre affiche son état initial',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ChronometreApp());

    expect(find.text('Mon Chronomètre'), findsOneWidget);
    expect(find.text('00:00:00'), findsOneWidget);
    expect(find.text('Démarrer'), findsOneWidget);
    expect(find.text('Réinitialiser'), findsOneWidget);
    expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
  });
}
