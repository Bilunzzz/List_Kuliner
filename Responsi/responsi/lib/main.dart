import 'package:flutter/material.dart';
import 'screen/homescreen.dart';
import 'screen/addrecipe.dart';
import 'screen/recipedetail.dart';
import 'db/db_helper.dart';
import 'model/recipe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
