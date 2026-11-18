import 'package:material_ui/material_ui.dart';

/// Palet warna "Afterburner", disalin dari variabel CSS situs web portofolio
/// (`static/css/afterburner.css`) agar aplikasi mobile terasa satu identitas
/// dengan versi web-nya.
abstract final class AppColors {
  /// Latar utama aplikasi (`--ab-void`).
  static const Color voidBlack = Color(0xFF0A0C10);

  /// Latar panel/kartu (`--ab-panel`).
  static const Color panel = Color(0xFF10131A);

  /// Garis tepi panel (`--ab-border`).
  static const Color border = Color(0xFF232933);

  /// Warna teks utama (`--ab-text`).
  static const Color text = Color(0xFFE6E8EB);

  /// Warna teks sekunder (`--ab-muted`).
  static const Color muted = Color(0xFF8A93A3);

  /// Warna aksen merah (`--ab-red`).
  static const Color red = Color(0xFFFC0000);
}

/// Tema gelap aplikasi yang dibangun dari [AppColors].
ThemeData buildAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.red,
      brightness: Brightness.dark,
      primary: AppColors.red,
      surface: AppColors.panel,
      onSurface: AppColors.text,
    ),
    scaffoldBackgroundColor: AppColors.voidBlack,
    useMaterial3: true,
  );
}
