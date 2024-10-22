import 'package:flutter/material.dart';
import 'package:list_kuliner/styles.dart';
import 'detail_page.dart';
import 'makanan.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Makanan> makananList = Makanan.listMakanan;

    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list_alt_sharp, size: 30),
            SizedBox(width: 10),
            Text(
              'List Kuliner',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        for (var makanan in makananList)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    gambar: makanan.gambar,
                    nama: makanan.nama,
                    waktubuka: makanan.waktubuka,
                    kalori: makanan.kalori,
                    harga: makanan.harga,
                    detail: makanan.detail,
                    gambarlain: makanan.gambarlain,
                    bahan: makanan.bahan,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 253, 204, 187),
                    offset: const Offset(1.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  gambar(makanan),
                  const SizedBox(width: 10),
                  deskripsiTeks(makanan),
                  Icon(
                    Icons.food_bank_rounded,
                    color: iconColor,
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }

  ClipRRect gambar(Makanan makanan) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        makanan.gambar,
        width: 85,
        height: 75,
        fit: BoxFit.cover,
      ),
    );
  }

  Expanded deskripsiTeks(Makanan makanan) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            makanan.nama,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            makanan.deskripsi,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          Text(
            makanan.harga,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
