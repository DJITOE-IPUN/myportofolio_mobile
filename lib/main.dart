import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/theme.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget aplikasi: mengatur judul, tema, dan halaman awal.
///
/// Berkas ini hanya berisi kode bootstrap; seluruh widget halaman utama
/// berada di `screens/menu.dart`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: MyHomePage(),
    );
  }
}
