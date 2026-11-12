class Produk {
  final String id;
  final String nama;
  final int harga;
  final String kategori;
  const Produk({
    required this.id,
    required this.nama,
    required this.harga,
    required this.kategori,
  });
}

const daftarProduk = <Produk>[
  Produk(id: 'p1', nama: 'Nasi Goreng', harga: 15000, kategori: 'Makanan'),
  Produk(id: 'p2', nama: 'Es Teh Manis', harga: 5000, kategori: 'Minuman'),
  Produk(id: 'p3', nama: 'Ayam Geprek', harga: 18000, kategori: 'Makanan'),
  Produk(id: 'p4', nama: 'Mie Goreng', harga: 14000, kategori: 'Makanan'),
  Produk(id: 'p5', nama: 'Jus Alpukat', harga: 12000, kategori: 'Minuman'),
];
