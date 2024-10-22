import 'package:flutter/material.dart';
import 'package:list_kuliner/styles.dart';
import 'makanan.dart';

class DetailPage extends StatelessWidget {
  final String gambar;
  final String nama;
  final String waktubuka;
  final String kalori;
  final String harga;
  final String detail;
  final List<String> gambarlain;
  final List<Map<String, String>> bahan;

  const DetailPage({
    super.key,
    required this.gambar,
    required this.nama,
    required this.waktubuka,
    required this.kalori,
    required this.harga,
    required this.detail,
    required this.gambarlain,
    required this.bahan,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pageBgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Image.asset(gambar, scale: 0.5),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [buttonBack(), buttonLike()],
                    ),
                  )
                ],
              ),
              Container(
                color: Colors.brown,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(nama,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  attributesIcon(Icons.access_time_filled, waktubuka),
                  attributesIcon(Icons.local_fire_department_rounded, kalori),
                  attributesIcon(Icons.monetization_on, harga),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              listGambarLain(),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Bahan Racikan", style: textHeader1)),
              listBahan(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox listBahan() {
    return SizedBox(
      child: Container(
        height: 100,
        child: ListView.builder(
            itemCount: bahan.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    Image.asset(bahan[index].values.first, width: 52),
                    Text(bahan[index].keys.first)
                  ],
                ),
              );
            }),
      ),
    );
  }

  SizedBox listGambarLain() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: gambarlain.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(gambarlain[index])),
          );
        },
      ),
    );
  }

  Column attributesIcon(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class buttonBack extends StatelessWidget {
  const buttonBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

class buttonLike extends StatefulWidget {
  const buttonLike({super.key});

  @override
  State<StatefulWidget> createState() => _buttonLike();
}

class _buttonLike extends State<buttonLike> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      child: IconButton(
        onPressed: () {
          setState(() {
            isSelected = !isSelected;
          });
        },
        icon: Icon(
          isSelected ? Icons.favorite : Icons.favorite_outline,
          color: const Color.fromARGB(255, 173, 13, 1),
        ),
      ),
    );
  }
}
