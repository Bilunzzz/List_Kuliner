import 'package:flutter/material.dart';
import 'package:list_kuliner/styles.dart';
import 'home_page.dart';
// import 'detail_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: pageBgColor, // Warna hex yang valid (RGB)
        appBar: AppBar(
          title: Text(
            "Kuliner Nusantara",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: HomePage(),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Center(
    child: Text(
      "Selamat Datang di Kuliner Nusantara!",
      style: TextStyle(fontSize: 18),
    ),
  );
}
