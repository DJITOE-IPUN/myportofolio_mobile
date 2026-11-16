import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  /// Menjalankan aplikasi pada layar ukuran ponsel (360 x 800 logical pixel).
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
  }

  testWidgets('MyHomePage adalah StatelessWidget', (WidgetTester tester) async {
    await pumpApp(tester);

    expect(tester.widget(find.byType(MyHomePage)), isA<StatelessWidget>());
  });

  testWidgets('InfoCard menampilkan identitas pemilik portofolio',
      (WidgetTester tester) async {
    await pumpApp(tester);

    expect(find.byType(InfoCard), findsNWidgets(3));
    expect(find.text('2506616674'), findsOneWidget);
    expect(find.text('Michael Evan Putra Nugroho'), findsOneWidget);
    expect(find.text('PBP C'), findsOneWidget);
    expect(find.text('Burhan'), findsNothing);
  });

  testWidgets('Setiap ItemCard memiliki warna latar yang unik',
      (WidgetTester tester) async {
    await pumpApp(tester);

    final cards = tester.widgetList<ItemCard>(find.byType(ItemCard)).toList();
    final colors = cards.map((ItemCard card) => card.item.color).toSet();

    expect(cards.length, greaterThanOrEqualTo(3));
    expect(colors.length, cards.length);
  });

  testWidgets('Menekan tombol menampilkan SnackBar sesuai nama tombol',
      (WidgetTester tester) async {
    await pumpApp(tester);

    final names = tester
        .widgetList<ItemCard>(find.byType(ItemCard))
        .map((ItemCard card) => card.item.name)
        .toList();

    for (final name in names) {
      await tester.tap(find.text(name));
      await tester.pumpAndSettle();

      expect(find.text('Kamu telah menekan tombol $name!'), findsOneWidget);
    }
  });
}
