import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final biodata = <String, String>{};
  MyApp({super.key}) {
    biodata['name'] = 'WM. Ngiras Roso';
    biodata['email'] = 'nabilulasad@gmail.com';
    biodata['phone'] = '+6285161698387';
    biodata['image'] = 'warung.jpg';
    biodata['hobby'] = 'Reading, Coding, Gaming';
    biodata['address'] =
        'Jl. Banowati Raya, Bulu Lor, Semarang Utara, Semarang';
    biodata['description'] =
        ''' Awali pagimu dengan sarapan, bukan dengan harapan. kelass king ''';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WM. Ngiras Roso",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Warung Makan Ngiras Roso"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              txtKotak(Colors.black, biodata['name'] ?? ''),
              Image(image: AssetImage('assets/${biodata['image'] ?? ''}')),
              SizedBox(height: 10),
              Row(
                children: [
                  btnContact(Icons.alternate_email, Colors.green[900],
                      "mailto:${biodata['email']}?subject=Tanya%20Seputar%20Resto"),
                  btnContact(Icons.phone, Colors.blueAccent,
                      "https://wa.me/${biodata['phone']}"),
                  btnContact(Icons.map, Colors.deepPurple[900],
                      "https://maps.app.goo.gl/mNyEr5vzdKiHfgYk8"),
                ],
              ),
              SizedBox(height: 10),
              txtKotak(Colors.black38, 'Deskripsi'),
              SizedBox(height: 10),
              Text(
                biodata['description'] ?? '',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              txtKotak(Colors.black38, 'List Menu'),
              SizedBox(height: 10),
              txtAttribute("Segala Masakan jawa"),
              txtAttribute("Ayam geprek"),
              txtAttribute("Gorengan"),
              SizedBox(height: 10),
              txtKotak(Colors.black38, 'Alamat'),
              SizedBox(height: 10),
              Text(
                biodata['address'] ?? '',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              txtKotak(Colors.black38, 'Jam Buka'),
              SizedBox(height: 10),
              txtAttribute("Buka 24 Jam"),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Container txtKotak(Color bgColor, String teks) {
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(color: bgColor),
        child: Text(teks,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white)));
  }

  Row txtAttribute(String judul) {
    return Row(
      children: [
        Container(
          width: 300,
          child: Text("- $judul", style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  Expanded btnContact(IconData icon, var color, String uri) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          launc(uri);
        },
        child: Icon(icon),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            textStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  void launc(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil :  $uri');
    }
  }
}
