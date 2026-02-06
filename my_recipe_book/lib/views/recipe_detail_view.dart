import 'package:flutter/material.dart';
import 'package:my_recipe_book/models/recipe.dart';
import 'package:provider/provider.dart';
import '../repositories/recipes_repository.dart';
import '../view_models/recipe_detail_view_model.dart';

class RecipeDetailView extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecipeDetailViewModel>(
      create: (context) => RecipeDetailViewModel(Provider.of<RecipesRepository>(context, listen: false))
        ..setRecipe(recipe),
      child: Consumer<RecipeDetailViewModel>(
        builder: (context, viewModel, _) {
          final displayRecipe = viewModel.recipe ?? recipe;
          return Scaffold(
            appBar: AppBar(
              title: Text(displayRecipe.title),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: AssetImage(displayRecipe.imagePath),
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayRecipe.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (displayRecipe.description.isNotEmpty)
                    Text(
                      displayRecipe.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (displayRecipe.ingredients.isNotEmpty)
                    ...displayRecipe.ingredients.map((ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ', style: TextStyle(fontSize: 16)),
                              Expanded(child: Text(ingredient, style: const TextStyle(fontSize: 16))),
                            ],
                          ),
                        )),
                  const SizedBox(height: 20),
                  const Text(
                    'Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (displayRecipe.steps.isNotEmpty)
                    ...displayRecipe.steps.asMap().entries.map((entry) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${entry.key + 1}. ', style: const TextStyle(fontSize: 16)),
                              Expanded(child: Text(entry.value, style: const TextStyle(fontSize: 16))),
                            ],
                          ),
                        )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
