import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../model/recipe.dart';

class AddRecipeScreen extends StatelessWidget {
  final Recipe? recipe;
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();

  final DBHelper _dbHelper = DBHelper();

  AddRecipeScreen({this.recipe}) {
    if (recipe != null) {
      _nameController.text = recipe!.name;
      _timeController.text = recipe!.preparationTime;
      _ingredientsController.text = recipe!.ingredients;
      _instructionsController.text = recipe!.instructions;
    }
  }

  Future<void> _saveRecipe() async {
    final newRecipe = Recipe(
      id: recipe?.id,
      name: _nameController.text,
      preparationTime: _timeController.text,
      ingredients: _ingredientsController.text,
      instructions: _instructionsController.text,
    );

    if (recipe == null) {
      await _dbHelper.insertRecipe(newRecipe.toMap());
    } else {
      await _dbHelper.updateRecipe(newRecipe.id!, newRecipe.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe == null ? 'Add Recipe' : 'Edit Recipe'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Resep'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Waktu Penyajian'),
            ),
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Bahan-bahan'),
            ),
            TextField(
              controller: _instructionsController,
              decoration: InputDecoration(labelText: 'Langkah-langkah'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveRecipe();
                Navigator.pop(context);
              },
              child: Text(recipe == null ? 'Add Recipe' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
