import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const KenangApp());
}

class KenangApp extends StatelessWidget {
  const KenangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kenang',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090909),
        colorScheme: ColorScheme.dark(
          primary: Colors.red.shade900,
        ),
      ),
      home: const PasswordPage(),
    );
  }
}

// =====================================================
// PASSWORD
// =====================================================

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController passwordController =
      TextEditingController();

  // PASSWORD APLIKASI
  final String password = 'kalamerta';

  bool hidePassword = true;
  bool passwordSalah = false;

  void masuk() {
    if (passwordController.text == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      setState(() {
        passwordSalah = true;
      });

      passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090909),
      body: Stack(
        children: [
          // MAWAR KIRI
          const Positioned(
            top: 40,
            left: 15,
            child: RoseWidget(),
          ),

          // MAWAR KANAN
          const Positioned(
            top: 40,
            right: 15,
            child: RoseWidget(),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  // ORNAMEN
                  const Text(
                    '❦',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 70,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'KENANG',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 9,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'sebuah ruang untuk yang pernah ada',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 45),

                  // ICON LOCK
                  const Icon(
                    Icons.lock_outline,
                    color: Colors.white54,
                    size: 35,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'RUANG PRIBADI',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 4,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // PASSWORD
                  TextField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    textAlign: TextAlign.center,
                    onSubmitted: (_) => masuk(),
                    style: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Masukkan password',
                      hintStyle: const TextStyle(
                        color: Colors.white30,
                        letterSpacing: 2,
                      ),
                      prefixIcon: const Icon(
                        Icons.key_outlined,
                        color: Colors.white38,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white38,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF151515),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.15),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.shade900,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (passwordSalah)
                    const Text(
                      'Password salah.',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),

                  const SizedBox(height: 25),

                  // TOMBOL
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: masuk,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'BUKA ARSIP',
                        style: TextStyle(
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 45),

                  Text(
                    '❦  arsip yang tak ingin dilupakan  ❦',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// HOME
// =====================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker picker = ImagePicker();

  List<String> photos = [];

  @override
  void initState() {
    super.initState();
    loadPhotos();
  }

  Future<void> loadPhotos() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      photos = prefs.getStringList('photos') ?? [];
    });
  }

  Future<void> addPhoto() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (image == null) return;

    final directory =
        await getApplicationDocumentsDirectory();

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${image.name}';

    final savedFile = await File(image.path).copy(
      '${directory.path}/$fileName',
    );

    photos.insert(0, savedFile.path);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('photos', photos);

    setState(() {});
  }

  Future<void> deletePhoto(int index) async {
    final file = File(photos[index]);

    if (await file.exists()) {
      await file.delete();
    }

    photos.removeAt(index);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('photos', photos);

    setState(() {});
  }

  void bukaFoto(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PhotoPage(
            path: photos[index],
            onDelete: () {
              deletePhoto(index);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090909),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'KENANG',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),
            Text(
              'arsip yang tak ingin dilupakan',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 9,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Center(
              child: Text(
                '❦',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          // MAWAR KIRI
          const Positioned(
            top: 5,
            left: 5,
            child: RoseWidget(),
          ),

          // MAWAR KANAN
          const Positioned(
            top: 5,
            right: 5,
            child: RoseWidget(),
          ),

          Column(
            children: [
              const SizedBox(height: 50),

              Text(
                photos.isEmpty
                    ? 'Belum ada kenangan'
                    : '${photos.length} kenangan tersimpan',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: photos.isEmpty
                    ? const EmptyState()
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          10,
                          20,
                          100,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: photos.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => bukaFoto(index),
                            child: MemoryCard(
                              path: photos[index],
                              number: index + 1,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: addPhoto,
        backgroundColor: Colors.red.shade900,
        icon: const Icon(Icons.add_a_photo),
        label: const Text(
          'Simpan Kenangan',
          style: TextStyle(
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// MEMORY CARD
// =====================================================

class MemoryCard extends StatelessWidget {
  final String path;
  final int number;

  const MemoryCard({
    super.key,
    required this.path,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 12,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(path),
              fit: BoxFit.cover,

              // Membuat foto menjadi hitam putih
              color: Colors.grey.shade300,
              colorBlendMode: BlendMode.saturation,
            ),
          ),

          Positioned(
            left: 8,
            bottom: 8,
            child: Text(
              'MEMORY ${number.toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 8,
                letterSpacing: 2,
              ),
            ),
          ),

          const Positioned(
            right: 7,
            top: 5,
            child: Text(
              '❦',
              style: TextStyle(
                color: Colors.red,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// DETAIL FOTO
// =====================================================

class PhotoPage extends StatelessWidget {
  final String path;
  final VoidCallback onDelete;

  const PhotoPage({
    super.key,
    required this.path,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'SEBUAH KENANGAN',
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 3,
          ),
        ),
        actions: [
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.white70,
            ),
          ),
        ],
      ),

      body: Center(
        child: InteractiveViewer(
          child: Image.file(
            File(path),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// EMPTY STATE
// =====================================================

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Text(
            '❦',
            style: TextStyle(
              color: Colors.red,
              fontSize: 65,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Belum ada cerita di sini.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Tambahkan sebuah foto untuk mengabadikannya.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// =====================================================
// MAWAR
// =====================================================

class RoseWidget extends StatelessWidget {
  const RoseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '✿',
          style: TextStyle(
            color: Colors.red,
            fontSize: 45,
          ),
        ),

        Container(
          width: 2,
          height: 25,
          color: Colors.white24,
        ),

        const Text(
          '❧',
          style: TextStyle(
            color: Colors.white30,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}