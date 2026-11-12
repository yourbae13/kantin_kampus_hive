import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../helpers/hive_helper.dart';
import '../models/produk.dart';
import '../models/produk_favorit.dart';
import '../widgets/product_card.dart';

class HalamanProduk extends StatelessWidget {
  const HalamanProduk({super.key});
  Future<void> simpanFavorit(BuildContext context, Produk produk) async {
    if (boxFavorit.containsKey(produk.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk sudah ada di favorit')),
      );
      return;
    }
    await boxFavorit.put(
      produk.id,
      ProdukFavorit(
        idProduk: produk.id,
        nama: produk.nama,
        harga: produk.harga,
      ),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${produk.nama} berhasil disimpan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produk Kantin')),
      body: ValueListenableBuilder<Box<ProdukFavorit>>(
        valueListenable: boxFavorit.listenable(),
        builder: (context, box, _) {
          return ListView.builder(
            itemCount: daftarProduk.length,
            itemBuilder: (context, index) {
              final produk = daftarProduk[index];
              return ProductCard(
                produk: produk,
                sudahFavorit: box.containsKey(produk.id),
                onFavorit: () => simpanFavorit(context, produk),
              );
            },
          );
        },
      ),
    );
  }
}
