import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme_cubit.dart';
import '../helpers/pengaturan_helper.dart';

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});
  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  final _nama = TextEditingController(text: PengaturanHelper.muatNama());
  @override
  void dispose() {
    _nama.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    final gelap = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Mode gelap'),
            subtitle: const Text('Disimpan dengan SharedPreferences'),
            value: gelap,
            onChanged: cubit.setGelap,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nama,
            decoration: const InputDecoration(
              labelText: 'Nama pelanggan',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              await PengaturanHelper.simpanNama(_nama.text);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Nama ${_nama.text} berhasil disimpan'),
                  ),
                );
              }
            },
            child: const Text('Simpan nama'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () async {
              await cubit.reset();
              if (mounted) _nama.clear();
            },
            child: const Text('Reset pengaturan'),
          ),
          const SizedBox(height: 8),
          const Text('Reset pengaturan tidak menghapus produk favorit.'),
        ],
      ),
    );
  }
}
