import 'package:flutter/material.dart';
import 'package:list_kuliner/makanan.dart';

class ListItem extends StatelessWidget {
  final Makanan menu;

  const ListItem({
    required this.menu,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            menu.gambar,
            width: 85,
            height: 75,
            fit: BoxFit.cover,
          ),
        ),
        Text(menu.nama),
      ],
    );
  }
}
