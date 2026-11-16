# MyPortfolio Mobile - Tugas Individu Pemrograman Berbasis Platform

**Nama**    : Michael Evan Putra Nugroho  
**NPM**     : 2506616674  
**Kelas**   : PBP C

Aplikasi mobile Flutter untuk portofolio pribadi. Aplikasi ini adalah pasangan dari situs web portofolio Django ([DJITOE-IPUN/MYPORTOFOLIO](https://github.com/DJITOE-IPUN/MYPORTOFOLIO)) dan memakai palet warna "Afterburner" yang sama (latar hampir hitam dengan aksen merah).

---

## Cara Menjalankan Proyek Secara Lokal (Setup Guide)

1. **Pastikan Flutter SDK Terpasang**
   ```bash
   flutter doctor
   ```

2. **Clone Repositori & Masuk ke Direktori**
   ```bash
   git clone https://github.com/DJITOE-IPUN/myportofolio_mobile.git
   cd myportofolio_mobile
   ```

3. **Instal Dependensi**
   ```bash
   flutter pub get
   ```

4. **Jalankan Analisis Kode & Unit Test**
   ```bash
   flutter analyze
   flutter test
   ```

5. **Jalankan Aplikasi**
   ```bash
   flutter run -d chrome
   ```
   Ganti `chrome` dengan emulator Android atau perangkat lain dari `flutter devices`.

---

## Struktur Proyek

```
lib/
├── main.dart    # Bootstrap aplikasi: MaterialApp, tema, halaman awal
├── menu.dart    # Halaman utama: MyHomePage, InfoCard, ItemHomepage, ItemCard
└── theme.dart   # Palet warna Afterburner dan ThemeData aplikasi
test/
└── widget_test.dart  # Widget test halaman utama
```

---

## Progres Mingguan

| Minggu | Pekerjaan | Ringkasan |
| --- | --- | --- |
| Tutorial 08 | Basic Flutter | Inisialisasi proyek, pemisahan `menu.dart`, `MyHomePage` sebagai `StatelessWidget`, `InfoCard` dan `ItemCard` dengan data contoh Burhan. |
| Tugas 7 | Basic Flutter | Identitas asli pada `InfoCard`, 4 tombol aksi dengan warna unik, SnackBar sesuai tombol, tema Afterburner, dan widget test. |

---

### Tugas 7: Basic Flutter

#### Ringkasan Perubahan Tugas 7

1. **Struktur Proyek (`lib/main.dart`, `lib/menu.dart`, `lib/theme.dart`)**:
   - `main.dart` hanya berisi kode bootstrap (`runApp` dan `MyApp`), sedangkan seluruh widget halaman utama ada di `menu.dart`.
   - `MyHomePage` tetap berupa `StatelessWidget` karena halaman ini tidak menyimpan state yang berubah.
   - Palet warna dipisahkan ke `theme.dart` (`AppColors` dan `buildAppTheme()`), disalin dari variabel CSS situs web (`--ab-void`, `--ab-panel`, `--ab-border`, `--ab-text`, `--ab-red`).
2. **Informasi Profil Pemilik Portofolio (`InfoCard`)**:
   - Tiga kartu menampilkan identitas asli: **NPM** `2506616674`, **Name** `Michael Evan Putra Nugroho`, dan **Class** `PBP C`. Data contoh Burhan sudah dihapus.
   - Kartu memakai `Expanded` di dalam `IntrinsicHeight`, bukan lebar tetap `MediaQuery.of(context).size.width / 3.5`, sehingga ketiga kartu selalu sama tinggi dan tidak *overflow* walaupun nama lengkap terpotong menjadi beberapa baris.
3. **Menu Aksi Portofolio (`ItemCard`) & Kustomisasi Warna**:
   - Empat tombol aksi yang sesuai dengan bagian situs web: **Lihat Proyek** (biru, `Icons.folder_open`), **Lihat Education** (ungu, `Icons.school`), **Tambah Proyek** (hijau, `Icons.add_circle`), dan **Logout** (merah, `Icons.logout`).
   - Model `ItemHomepage` memiliki atribut `Color color`. `ItemCard` cukup membaca `item.color`, sehingga tidak ada percabangan if-else untuk pewarnaan dan tombol baru cukup ditambahkan satu baris di list `items`.
   - Kisi disusun 2 x 2 (`crossAxisCount: 2`) dan dibatasi lebar maksimal 560 px agar tetap proporsional saat dijalankan di Chrome.
4. **SnackBar Interaktif**:
   - Menekan tombol menampilkan pesan **"Kamu telah menekan tombol [Nama Tombol]!"**.
   - SnackBar dibuat *floating*, memakai warna dan ikon yang sama dengan tombolnya, dan `hideCurrentSnackBar()` dipanggil lebih dulu agar pesan langsung berganti saat tombol lain ditekan.
5. **Penyesuaian UI/UX Tambahan**:
   - Tema gelap Afterburner (`ColorScheme.fromSeed` dengan `Brightness.dark`), judul kartu berwarna merah aksen, dan *ripple* `InkWell` yang mengikuti sudut kartu.
   - `SingleChildScrollView` mencegah *overflow* di layar pendek atau mode landscape.
6. **Kualitas Kode & Pengujian (`test/widget_test.dart`)**:
   - Test bawaan `flutter create` (*counter smoke test*) diganti dengan 4 widget test: `MyHomePage` adalah `StatelessWidget`, `InfoCard` menampilkan identitas asli, setiap `ItemCard` memiliki warna unik, dan setiap tombol memunculkan SnackBar dengan pesan yang sesuai.
   - `flutter analyze` menghasilkan **No issues found!** dan `flutter test` lulus seluruhnya.

---

#### Pertanyaan Reflektif

1. **Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**
   - **Widget tree** adalah susunan hierarkis seluruh widget yang membentuk tampilan aplikasi. Di Flutter, hampir semua hal adalah widget, mulai dari tata letak (`Column`, `Padding`) sampai teks dan ikon. Setiap widget menyusun widget lain di dalam metode `build()`, sehingga terbentuk pohon. Di proyek ini: `MyApp` → `MaterialApp` → `MyHomePage` → `Scaffold` → `AppBar` dan `SingleChildScrollView` → `Column` → `Row` berisi tiga `InfoCard` dan `GridView` berisi empat `ItemCard`.
   - **Hubungan parent-child**:
     - **Constraint turun, ukuran naik, parent menentukan posisi**: parent memberi batasan ukuran (*constraints*) kepada child, child memilih ukurannya di dalam batasan tersebut, lalu parent menempatkan child. Contohnya, `Expanded` di dalam `Row` memaksa setiap `InfoCard` mengambil sepertiga lebar baris.
     - **Data mengalir dari atas ke bawah**: parent mengirim data ke child lewat parameter konstruktor, misalnya `MyHomePage` mengirim `title` dan `content` ke `InfoCard`, atau objek `ItemHomepage` ke `ItemCard`.
     - **Child dapat membaca leluhurnya**: lewat `BuildContext`, widget di bawah bisa mengambil data dari widget di atasnya, misalnya `ScaffoldMessenger.of(context)` di `ItemCard` mencari `ScaffoldMessenger` yang disediakan `MaterialApp`.
     - Widget yang hanya menerima satu anak memakai properti `child` (`Padding`, `Center`, `Card`), sedangkan widget yang menerima banyak anak memakai `children` (`Column`, `Row`, `GridView`).

2. **Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**
   - **Widget buatan sendiri**:
     - `MyApp`: *root widget* aplikasi yang mengembalikan `MaterialApp`.
     - `MyHomePage`: halaman utama yang menyusun kartu identitas dan menu aksi.
     - `InfoCard`: kartu berisi judul dan isi identitas (NPM, Name, Class).
     - `ItemCard`: kartu tombol aksi berwarna yang menampilkan SnackBar saat ditekan. Datanya berasal dari model `ItemHomepage` (kelas biasa, bukan widget).
   - **Struktur aplikasi & halaman**:
     - `MaterialApp`: menyediakan tema, navigasi, judul aplikasi, dan `ScaffoldMessenger` untuk SnackBar.
     - `Scaffold`: kerangka halaman Material Design (AppBar, body, area SnackBar).
     - `AppBar`: bar judul "MyPortfolio" di bagian atas.
     - `SnackBar`: pesan singkat di bawah layar setelah tombol ditekan, ditampilkan lewat `ScaffoldMessenger`.
   - **Tata letak**:
     - `SingleChildScrollView`: membuat isi halaman bisa di-*scroll* agar tidak *overflow*.
     - `Center`: menempatkan konten di tengah.
     - `ConstrainedBox`: membatasi lebar maksimal konten menjadi 560 px.
     - `Column`: menyusun widget secara vertikal.
     - `Row`: menyusun tiga `InfoCard` secara horizontal; juga menyusun ikon dan teks di dalam SnackBar.
     - `IntrinsicHeight`: menyamakan tinggi ketiga `InfoCard` dengan kartu tertinggi.
     - `Expanded`: membagi ruang `Row` secara merata, juga membungkus teks SnackBar agar bisa turun baris.
     - `Padding`: memberi jarak di sekeliling widget.
     - `SizedBox`: memberi jarak tetap antarwidget.
     - `GridView.count`: menyusun empat `ItemCard` dalam kisi 2 kolom.
   - **Tampilan & interaksi**:
     - `Card`: wadah `InfoCard` dengan bayangan, sudut membulat, dan garis tepi.
     - `Material`: memberi warna latar unik dan sudut membulat pada `ItemCard`, sekaligus menjadi permukaan untuk efek *ripple*.
     - `InkWell`: menangkap ketukan (`onTap`) dan menampilkan efek *ripple*.
     - `Text`: menampilkan teks.
     - `Icon`: menampilkan ikon Material pada tombol dan SnackBar.

3. **Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**
   - **Fungsi**: `MaterialApp` membungkus aplikasi dengan fondasi Material Design: tema global (`theme`, di proyek ini `buildAppTheme()`), navigasi dan *routing* (`home`, `routes`, `Navigator`), judul aplikasi (`title`), lokalisasi, arah teks, serta `ScaffoldMessenger` untuk menampilkan SnackBar.
   - **Mengapa menjadi root widget**: banyak widget Material bergantung pada widget leluhur yang disediakan oleh `MaterialApp`. `Theme.of(context)` membutuhkan `Theme`, `ScaffoldMessenger.of(context)` membutuhkan `ScaffoldMessenger`, dan widget seperti `Text` serta `AppBar` membutuhkan `Directionality` dan `MediaQuery`. Karena dicari ke atas lewat `BuildContext`, widget-widget ini harus berada di atas seluruh halaman, sehingga `MaterialApp` diletakkan paling atas. Contohnya, SnackBar di `ItemCard` hanya bisa muncul karena `MaterialApp` sudah menyediakan `ScaffoldMessenger` di atasnya.

4. **Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**
   - **StatelessWidget**: tidak memiliki state internal yang bisa berubah. Tampilannya hanya bergantung pada parameter konstruktor dan data dari leluhur (misalnya tema), lalu digambar ulang saat parent membangunnya ulang dengan data baru. Semua field-nya `final`.
   - **StatefulWidget**: dipasangkan dengan objek `State` yang tetap hidup selama widget ada di tree. Ketika data di dalam `State` berubah, `setState()` memicu `build()` ulang. `State` juga punya *lifecycle* seperti `initState()` dan `dispose()` untuk menyiapkan dan membersihkan *resource* (controller, stream, timer).
   - **Kapan memilih StatelessWidget**: ketika tampilan hanya menampilkan data yang tidak berubah selama widget hidup, misalnya `MyHomePage`, `InfoCard`, dan `ItemCard` di proyek ini. SnackBar pun tidak membutuhkan state karena dikelola oleh `ScaffoldMessenger`. Widget ini lebih sederhana, ringan, dan mudah diuji.
   - **Kapan memakai StatefulWidget**: ketika tampilan harus berubah akibat interaksi atau data yang datang belakangan, misalnya *counter*, *checkbox*, input form dengan `TextEditingController`, animasi, atau daftar proyek yang diambil dari API Django dan perlu menampilkan status *loading*.

5. **Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**
   - **BuildContext** adalah penanda posisi sebuah widget di dalam widget tree (secara teknis, *handle* ke `Element` milik widget tersebut). Setiap widget mendapat `context` miliknya sendiri saat `build(BuildContext context)` dipanggil.
   - **Mengapa penting**: lewat `context`, widget bisa mencari data dan layanan dari leluhurnya tanpa harus menerimanya satu per satu lewat konstruktor. Ini yang membuat tema, navigasi, ukuran layar, dan SnackBar bisa diakses dari widget mana pun.
   - **Penggunaan di dalam build**:
     - `ScaffoldMessenger.of(context)` di `ItemCard` untuk menampilkan SnackBar.
     - `Theme.of(context)` untuk membaca tema aplikasi.
     - `MediaQuery.of(context)` untuk membaca ukuran layar (dipakai di Tutorial 08 untuk lebar `InfoCard`).
     - `Navigator.of(context)` untuk berpindah halaman.
   - **Hal yang perlu diperhatikan**: `context` hanya bisa menemukan widget yang berada di atasnya. Misalnya, `context` milik widget yang membuat `Scaffold` tidak bisa menemukan `Scaffold` itu sendiri lewat `Scaffold.of(context)`. Karena itu SnackBar dipanggil dari `context` milik `ItemCard` yang berada di bawah `Scaffold` dan `ScaffoldMessenger`.

6. **Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**
   - **Hot reload** (`r` di terminal `flutter run`) menyuntikkan kode Dart yang berubah ke Dart VM yang sedang berjalan, lalu membangun ulang widget tree. State aplikasi tetap dipertahankan, sehingga perubahan tampilan (misalnya warna tombol atau teks SnackBar) langsung terlihat tanpa kehilangan posisi atau data yang sedang tampil.
   - **Hot restart** (`R`) memuat ulang seluruh kode Dart dan menjalankan aplikasi dari awal (`main()`). State hilang, tetapi lebih cepat daripada *full restart* karena kode *native* tidak dikompilasi ulang.
   - **Kapan hot reload tidak cukup (perlu hot restart)**:
     - Mengubah kode yang hanya dijalankan sekali, seperti `main()`, `initState()`, atau nilai awal variabel global dan field `static`.
     - Mengubah struktur tipe data, misalnya mengubah `enum` menjadi class, mengubah parameter generic, atau mengubah `StatelessWidget` menjadi `StatefulWidget` (dan sebaliknya).
     - Ketika state lama sudah tidak cocok dengan kode baru sehingga tampilan menjadi tidak konsisten.
   - **Kapan perlu full restart (stop lalu `flutter run` ulang)**:
     - Mengubah kode *native* (Kotlin/Java di `android/`, Swift di `ios/`) atau konfigurasi platform seperti `AndroidManifest.xml`.
     - Menambah *package* atau plugin baru di `pubspec.yaml` yang memiliki kode *native*, karena plugin tersebut harus dikompilasi dan didaftarkan ulang ke aplikasi.

---

#### AI Disclosure

* **Tools AI yang Digunakan**: Gemini (Google AI).
* **Link / Public Share Log Chat**: *ristek.link/AI-chat-log-tugas-7*

##### 1. Strategi Prompting & Arsitektur Interaksi
Proses pengerjaan Tugas 7 menerapkan metode **Iterative System-Constrained Prompting**. Pengembang menetapkan instruksi dan parameter ketat:
* **Specification-First**: AI diminta membaca halaman soal Tugas 7 serta kode hasil Tutorial 08 di repositori (`main.dart`, `menu.dart`) sebelum menulis kode, agar struktur Tutorial 08 tetap dipertahankan.
* **Brand Consistency**: Warna aplikasi diambil dari variabel CSS situs web portofolio (`afterburner.css`), bukan warna acak, agar aplikasi mobile satu identitas dengan versi web.
* **Verification Before Commit**: Seluruh perubahan wajib lolos `flutter analyze` (*No issues found*) dan `flutter test` sebelum di-*commit*, dengan *commit* terpisah per perubahan.

##### 2. Kronologi Log Prompting Utama

| Tahap | Tujuan Prompt | Luaran AI (*Output*) | Tindakan & Evaluasi Pengembang |
| --- | --- | --- | --- |
| **01** | Pemisahan palet warna dan tema aplikasi. | `lib/theme.dart` berisi `AppColors` dan `buildAppTheme()`; `main.dart` memakai tema tersebut. | **Disetujui**: Nilai warna dicocokkan dengan variabel `--ab-*` di `afterburner.css`. |
| **02** | Identitas asli pada `InfoCard`. | NPM, nama lengkap, dan kelas PBP C; tata letak `Expanded` + `IntrinsicHeight`. | **Disetujui**: Memastikan data Burhan sudah tidak tersisa. |
| **03** | Tombol aksi dengan warna unik dan SnackBar. | Atribut `Color color` pada `ItemHomepage`, 4 tombol berwarna, SnackBar *floating* berwarna sesuai tombol. | **Disetujui**: Pesan SnackBar dicocokkan persis dengan format soal. |
| **04** | Penggantian widget test bawaan. | 4 widget test untuk identitas, warna unik, SnackBar, dan `StatelessWidget`. | **Koreksi**: Test *counter* bawaan dihapus (lihat Analisis Keterbatasan AI poin 2). |
| **05** | Penulisan README Tugas 7. | Ringkasan perubahan, 6 jawaban pertanyaan reflektif, dan AI Disclosure. | **Disetujui**: Format disamakan dengan README repositori Django. |

##### 3. Analisis Keterbatasan AI

Dalam proses pengembangan Tugas 7, ditemukan 3 keterbatasan AI yang berhasil diidentifikasi dan dikoreksi (*Human-in-the-Loop*):

1. **AI Tidak Dapat Menjalankan Flutter SDK**
   - *Keterbatasan AI*: Lingkungan kerja AI tidak bisa mengunduh Flutter SDK, sehingga AI tidak dapat menjalankan `flutter analyze`, `flutter test`, maupun aplikasinya sendiri.
   - *Dampak*: Kode yang ditulis AI belum terbukti bebas *lint* dan *error* hanya dari pembacaan kode.
   - *Perbaikan*: `flutter analyze` dan `flutter test` dijalankan di laptop pengembang, dan proses *commit* dihentikan otomatis jika salah satunya gagal. Pada percobaan pertama, `flutter analyze` bersih tetapi `flutter test` menemukan *RenderFlex overflowed by 20 pixels* pada `Column` di `ItemCard`, karena kartu setinggi 92 px tidak cukup untuk ikon dan label dua baris di layar ponsel. Perbaikannya: `childAspectRatio` diturunkan dari 1.5 menjadi 1.25 dan label dibungkus `Flexible` dengan `maxLines: 2` serta `TextOverflow.ellipsis`, sehingga label tidak pernah melebihi ruang kartu.

2. **Test Bawaan `flutter create` yang Tertinggal dari Tutorial 08**
   - *Keterbatasan AI*: Kode Tutorial 08 yang dibantu AI tidak memperbarui `test/widget_test.dart`, sehingga masih berisi *counter smoke test* bawaan `flutter create`.
   - *Dampak*: `flutter test` akan gagal karena tombol `+` dan teks `0` tidak ada lagi di aplikasi. `flutter analyze` tidak mendeteksinya karena kodenya tetap valid secara sintaks.
   - *Perbaikan*: Mengganti test tersebut dengan 4 widget test yang sesuai dengan halaman portofolio.

3. **Lebar Tetap `InfoCard` dari Tutorial 08**
   - *Keterbatasan AI*: Kode Tutorial 08 memakai lebar `MediaQuery.of(context).size.width / 3.5` untuk setiap `InfoCard`. Ukuran ini cocok untuk data contoh yang pendek ("Burhan"), tetapi tidak memperhitungkan nama asli yang panjang.
   - *Dampak*: Nama "Michael Evan Putra Nugroho" terpotong menjadi beberapa baris sehingga tinggi ketiga kartu tidak sama, dan tata letak berisiko *overflow* di layar sempit.
   - *Perbaikan*: Mengganti lebar tetap dengan `Expanded` di dalam `IntrinsicHeight` dan `CrossAxisAlignment.stretch`, sehingga lebar terbagi rata dan tinggi kartu selalu seragam.

##### 4. Ringkasan Intervensi Kode Mandiri (*Code Ownership*)
Seluruh pemisahan `main.dart`, `menu.dart`, dan `theme.dart`, identitas asli pada `InfoCard`, atribut `color` pada model `ItemHomepage`, empat tombol `ItemCard` beserta SnackBar-nya, hingga 4 widget test pada `flutter test` telah diverifikasi, diuji, dan dipastikan berjalan stabil dengan hasil `flutter analyze` **No issues found!**.

---
