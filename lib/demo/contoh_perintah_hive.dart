import 'package:hive/hive.dart';

// Opsional: panggil setelah bukaBoxFavorit(), hanya saat latihan.
Future<void> demonstrasiPerintahHive() async {
  final box = await Hive.openBox('latihanProduk');
  await box.clear(); // Supaya output latihan dapat diulang.
  await box.put('p1', {'nama': 'Nasi Goreng', 'harga': 15000});
  await box.put('p1', {'nama': 'Nasi Goreng', 'harga': 17000});
  final keyOtomatis = await box.add({'nama': 'Es Teh', 'harga': 5000});
  await box.putAll({
    'p2': {'nama': 'Ayam Geprek', 'harga': 18000},
    'p3': {'nama': 'Mie Goreng', 'harga': 14000},
  });
  print('Nilai p1: ${box.get('p1')}');
  print('Key add(): $keyOtomatis');
  print('Jumlah entri: ${box.length}');
  await box.close();
}
