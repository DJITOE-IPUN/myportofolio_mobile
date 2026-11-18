import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

/// Halaman utama MyPortfolio Mobile.
///
/// Menampilkan identitas pemilik portofolio dalam tiga [InfoCard] dan menu
/// aksi portofolio dalam bentuk kisi [ItemCard]. Halaman ini tidak menyimpan
/// state yang berubah, sehingga cukup berupa [StatelessWidget].
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506616674";
  final String nama = "Michael Evan Putra Nugroho";
  final String kelas = "PBP C";

  /// Daftar tombol aksi portofolio.
  ///
  /// Warna latar setiap tombol disimpan langsung di model [ItemHomepage],
  /// sehingga [ItemCard] tidak memerlukan percabangan if-else untuk pewarnaan.
  /// Menambah tombol baru cukup dengan menambah satu baris di list ini.
  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder_open, Colors.blue.shade700),
    ItemHomepage("Lihat Education", Icons.school, Colors.deepPurple),
    ItemHomepage("Tambah Proyek", Icons.add_circle, Colors.green.shade700),
    ItemHomepage("Logout", Icons.logout, Colors.red.shade700),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur visual dasar halaman (AppBar, body, SnackBar).
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.panel,
        foregroundColor: AppColors.text,
      ),
      // Drawer menu untuk berpindah ke halaman lain.
      drawer: const LeftDrawer(),
      // SingleChildScrollView mencegah overflow di layar pendek atau saat
      // perangkat diputar ke mode landscape.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Membatasi lebar konten agar tetap proporsional di Chrome/tablet.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                // IntrinsicHeight + stretch membuat ketiga InfoCard sama tinggi,
                // walaupun nama lengkap terpotong menjadi beberapa baris.
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: InfoCard(title: 'NPM', content: npm)),
                      Expanded(child: InfoCard(title: 'Name', content: nama)),
                      Expanded(child: InfoCard(title: 'Class', content: kelas)),
                    ],
                  ),
                ),

                const SizedBox(height: 16.0),

                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Selamat datang di MyPortfolio Mobile!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),

                // GridView menampilkan kartu tombol dalam kisi 2 kolom (2 x 2).
                GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  crossAxisCount: 2,
                  // Rasio 1.25 memberi ruang cukup untuk ikon dan label dua baris
                  // di layar ponsel yang sempit.
                  childAspectRatio: 1.25,
                  // shrinkWrap agar tinggi kisi mengikuti isinya; scroll
                  // ditangani oleh SingleChildScrollView di atas.
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: items.map((ItemHomepage item) {
                    return ItemCard(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Kartu informasi berisi judul ([title]) dan isi ([content]).
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.panel,
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        // Menyusun judul dan isi secara vertikal di tengah kartu.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.text),
            ),
          ],
        ),
      ),
    );
  }
}

/// Model data untuk satu tombol aksi di halaman utama.
class ItemHomepage {
  final String name;
  final IconData icon;

  /// Warna latar unik untuk tombol ini.
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}
