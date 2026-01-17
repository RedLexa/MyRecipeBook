import 'package:my_recipe_book/models/recipe.dart';
import 'package:my_recipe_book/services/recipes_service.dart';

class RecipesRepository {
  RecipesService recipesService;

  RecipesRepository(this.recipesService);

  List getAllRecipes() {
    return recipesService.getAllRecipes();
  }

  RecipeModel getRecipe(int id) {
    return recipesService.getRecipe(id);
  }

  int getRecipesLength() {
    return recipesService.getRecipesLength();
  }
}