import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

/// Kartu tombol aksi yang menampilkan ikon dan nama dari [item].
///
/// Saat ditekan, kartu menampilkan SnackBar dengan warna yang sama seperti
/// kartunya, lalu berpindah ke halaman yang sesuai bila ada.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  static const BorderRadius _radius = BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    return Material(
      // Warna latar diambil dari model, sehingga tiap tombol berbeda warna.
      color: item.color,
      borderRadius: _radius,
      elevation: 2.0,
      child: InkWell(
        // borderRadius yang sama agar efek ripple tidak keluar dari sudut kartu.
        borderRadius: _radius,
        onTap: () {
          // Menutup SnackBar sebelumnya agar pesan langsung berganti, lalu
          // menampilkan pesan sesuai nama tombol yang ditekan.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: item.color,
                content: Row(
                  children: [
                    Icon(item.icon, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Kamu telah menekan tombol ${item.name}!",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );

          // Navigate ke halaman yang sesuai. push() menumpuk halaman form di
          // atas menu, sehingga tombol Back kembali ke menu.
          if (item.name == "Tambah Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectFormPage(),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                color: Colors.white,
                size: 30.0,
              ),
              const SizedBox(height: 6),
              // Flexible membatasi label pada sisa ruang kartu, sehingga label
              // yang panjang dipotong dengan elipsis alih-alih membuat overflow.
              Flexible(
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
