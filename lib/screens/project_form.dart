import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan proyek baru ke portofolio.
///
/// Berupa [StatefulWidget] karena nilai setiap field berubah seiring input
/// pengguna. Data belum disimpan ke database; setelah lolos validasi, isinya
/// ditampilkan dalam pop-up [AlertDialog].
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  /// Kunci untuk mengakses [FormState]: validasi dan reset form.
  final _formKey = GlobalKey<FormState>();

  static const String _defaultCategory = 'Web Development';

  String _projectName = "";
  String _description = "";
  String _category = _defaultCategory;
  String _technologies = "";
  String _projectLink = "";

  final List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  /// Mengosongkan form beserta variabel penampungnya.
  ///
  /// `reset()` hanya mengembalikan tampilan field ke nilai awal, jadi variabel
  /// state juga dikembalikan agar isian lama tidak ikut muncul di pop-up
  /// berikutnya ketika field opsional tidak diisi ulang.
  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _projectName = "";
      _description = "";
      _category = _defaultCategory;
      _technologies = "";
      _projectLink = "";
    });
  }

  /// Dekorasi field yang seragam untuk seluruh input.
  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      hintText: hint ?? label,
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Project Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.panel,
        foregroundColor: AppColors.text,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            // Lebar maksimal sama dengan halaman utama agar rapi di Chrome.
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Project Name ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: _decoration("Nama Proyek"),
                      onChanged: (String? value) {
                        setState(() {
                          _projectName = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Nama proyek tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),

                  // === Description ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: _decoration("Deskripsi Proyek"),
                      onChanged: (String? value) {
                        setState(() {
                          _description = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Deskripsi proyek tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),

                  // === Category ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Kategori Proyek",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Nilai awal tetap (bukan _category) supaya reset() selalu
                      // mengembalikan dropdown ke kategori default.
                      initialValue: _defaultCategory,
                      // isExpanded membuat item mengikuti lebar field, sehingga
                      // nama kategori yang panjang dipotong, bukan overflow.
                      isExpanded: true,
                      items: _categories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _category = newValue!;
                        });
                      },
                    ),
                  ),

                  // === Technologies ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: _decoration(
                        "Teknologi yang Digunakan",
                        hint: "Contoh: Flutter, Django, Figma",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _technologies = value!;
                        });
                      },
                    ),
                  ),

                  // === Project Link ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: _decoration(
                        "Tautan Proyek",
                        hint: "URL Proyek (opsional)",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _projectLink = value!;
                        });
                      },
                    ),
                  ),

                  // === Tombol Simpan ===
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.red),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Proyek berhasil ditambahkan!'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Nama Proyek: $_projectName'),
                                        Text('Deskripsi: $_description'),
                                        Text('Kategori: $_category'),
                                        Text('Teknologi: $_technologies'),
                                        Text('Tautan: $_projectLink'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _resetForm();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
