import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../helpers/hive_helper.dart';
import '../models/produk_favorit.dart';

class HalamanFavorit extends StatelessWidget {
  const HalamanFavorit({super.key});
  Future<void> _editCatatan(BuildContext context, ProdukFavorit favorit) async {
    var draf = favorit.catatan;
    final hasil = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ubah catatan favorit'),
        content: TextFormField(
          initialValue: draf,
          decoration: const InputDecoration(hintText: 'Contoh: tanpa sambal'),
          onChanged: (nilai) => draf = nilai,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, draf.trim()),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (hasil == null || !favorit.isInBox) return;
    favorit.catatan = hasil;
    await favorit.save();
  }

  Future<void> _hapusFavorit(
    BuildContext context,
    ProdukFavorit favorit,
  ) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus favorit?'),
        content: Text('Hapus ${favorit.nama} dari daftar favorit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (konfirmasi == true) {
      await boxFavorit.delete(favorit.idProduk);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produk Favorit')),
      body: ValueListenableBuilder<Box<ProdukFavorit>>(
        valueListenable: boxFavorit.listenable(),
        builder: (context, box, _) {
          final daftar = box.values.toList();
          if (daftar.isEmpty) {
            return const Center(child: Text('Belum ada produk favorit'));
          }
          return ListView.builder(
            itemCount: daftar.length,
            itemBuilder: (context, index) {
              final favorit = daftar[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: ListTile(
                  title: Text(favorit.nama),
                  subtitle: Text(
                    'Rp ${favorit.harga}\n'
                    'Catatan: ${favorit.catatan.isEmpty ? "-" : favorit.catatan}',
                  ),
                  isThreeLine: true,
                  onTap: () => _editCatatan(context, favorit),
                  trailing: IconButton(
                    tooltip: 'Hapus favorit',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _hapusFavorit(context, favorit),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
