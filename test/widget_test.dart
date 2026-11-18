import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

void main() {
  /// Menjalankan aplikasi pada layar ukuran ponsel (360 x 800 logical pixel).
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
  }

  /// Membuka drawer pada Scaffold yang sedang tampil.
  Future<void> openDrawer(WidgetTester tester) async {
    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();
  }

  /// Membuka halaman form lewat tombol "Tambah Proyek" di menu.
  Future<void> openForm(WidgetTester tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();
  }

  group('Halaman utama', () {
    testWidgets('MyHomePage adalah StatelessWidget',
        (WidgetTester tester) async {
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

        expect(find.text('Kamu telah menekan tombol $name!'), findsWidgets);

        // Tombol yang berpindah halaman: kembali dulu ke menu.
        if (find.byType(ProjectFormPage).evaluate().isNotEmpty) {
          Navigator.of(tester.element(find.byType(ProjectFormPage))).pop();
          await tester.pumpAndSettle();
        }
      }
    });
  });

  group('Navigasi', () {
    testWidgets('Tombol Tambah Proyek membuka form dengan push()',
        (WidgetTester tester) async {
      await openForm(tester);

      expect(find.byType(ProjectFormPage), findsOneWidget);
      expect(find.text('Add Project Form'), findsOneWidget);

      // push() menumpuk halaman, jadi pop() kembali ke menu.
      Navigator.of(tester.element(find.byType(ProjectFormPage))).pop();
      await tester.pumpAndSettle();

      expect(find.byType(MyHomePage), findsOneWidget);
      expect(find.byType(ProjectFormPage), findsNothing);
    });

    testWidgets('Drawer berisi menu Home dan Add Project',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await openDrawer(tester);

      expect(find.byType(LeftDrawer), findsOneWidget);
      expect(find.text('My Portfolio'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Add Project'), findsOneWidget);
    });

    testWidgets('Drawer Add Project mengganti menu dengan form',
        (WidgetTester tester) async {
      await pumpApp(tester);
      await openDrawer(tester);
      await tester.tap(find.text('Add Project'));
      await tester.pumpAndSettle();

      expect(find.byType(ProjectFormPage), findsOneWidget);
      // pushReplacement() membuang menu dari stack.
      expect(find.byType(MyHomePage, skipOffstage: false), findsNothing);

      // Dari form, drawer Home kembali ke halaman utama.
      await openDrawer(tester);
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(find.byType(MyHomePage), findsOneWidget);
      expect(find.byType(ProjectFormPage, skipOffstage: false), findsNothing);
    });
  });

  group('Form tambah proyek', () {
    testWidgets('Field wajib kosong menampilkan pesan error',
        (WidgetTester tester) async {
      await openForm(tester);

      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
      expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('Save menampilkan isian form di pop-up lalu mereset form',
        (WidgetTester tester) async {
      await openForm(tester);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'MyPortfolio Mobile');
      await tester.enterText(fields.at(1), 'Aplikasi portofolio Flutter');
      await tester.enterText(fields.at(2), 'Flutter, Django');
      await tester.enterText(fields.at(3), 'https://github.com/DJITOE-IPUN');

      // Memilih kategori lain pada dropdown.
      await tester.tap(find.text('Web Development'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mobile Development').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
      expect(find.text('Nama Proyek: MyPortfolio Mobile'), findsOneWidget);
      expect(
          find.text('Deskripsi: Aplikasi portofolio Flutter'), findsOneWidget);
      expect(find.text('Kategori: Mobile Development'), findsOneWidget);
      expect(find.text('Teknologi: Flutter, Django'), findsOneWidget);
      expect(
          find.text('Tautan: https://github.com/DJITOE-IPUN'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('MyPortfolio Mobile'), findsNothing);

      // Setelah reset, isian lama tidak boleh terbawa ke pop-up berikutnya.
      await tester.enterText(fields.at(0), 'Proyek Kedua');
      await tester.enterText(fields.at(1), 'Deskripsi kedua');
      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Nama Proyek: Proyek Kedua'), findsOneWidget);
      expect(find.text('Kategori: Web Development'), findsOneWidget);
      expect(find.text('Teknologi: '), findsOneWidget);
      expect(find.text('Tautan: '), findsOneWidget);
    });
  });
}
