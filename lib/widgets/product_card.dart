import 'package:flutter/material.dart';
import '../models/produk.dart';

class ProductCard extends StatelessWidget {
  final Produk produk;
  final bool sudahFavorit;
  final VoidCallback onFavorit;
  const ProductCard({
    super.key,
    required this.produk,
    required this.sudahFavorit,
    required this.onFavorit,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            produk.kategori == 'Minuman' ? Icons.local_drink : Icons.restaurant,
          ),
        ),
        title: Text(produk.nama),
        subtitle: Text('${produk.kategori} | Rp ${produk.harga}'),
        trailing: IconButton(
          tooltip: sudahFavorit ? 'Sudah favorit' : 'Tambah favorit',
          icon: Icon(
            sudahFavorit ? Icons.favorite : Icons.favorite_border,
            color: sudahFavorit ? Colors.red : null,
          ),
          onPressed: onFavorit,
        ),
      ),
    );
  }
}
