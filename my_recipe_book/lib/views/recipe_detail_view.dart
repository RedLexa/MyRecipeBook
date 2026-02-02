import 'package:flutter/material.dart';
import 'package:my_recipe_book/models/recipe.dart';

class RecipeDetailView extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: AssetImage(recipe.imagePath),
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (recipe.description != null && recipe.description!.isNotEmpty)
              Text(
                recipe.description!,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 20),
            Text(
              'Ingredients',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (recipe.ingredients.isNotEmpty)
              ...recipe.ingredients.map((ingredient) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 16)),
                        Expanded(child: Text(ingredient, style: TextStyle(fontSize: 16))),
                      ],
                    ),
                  )),
            const SizedBox(height: 20),
            Text(
              'Instructions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (recipe.steps.isNotEmpty)
              ...recipe.steps.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${entry.key + 1}. ', style: TextStyle(fontSize: 16)),
                        Expanded(child: Text(entry.value, style: TextStyle(fontSize: 16))),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
