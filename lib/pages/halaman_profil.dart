import 'package:flutter/material.dart';
import '../helpers/pengaturan_helper.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    String nama = PengaturanHelper.muatNama();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Profil")),
        body: Center(child: Text("Nama: $nama")),
      ),
    );
  }
}
