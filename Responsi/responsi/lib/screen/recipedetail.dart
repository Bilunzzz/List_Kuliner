import 'package:flutter/material.dart';
import '../model/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preparation Time: ${recipe.preparationTime}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.ingredients),
            SizedBox(height: 10),
            Text('Instructions:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}
