import 'package:my_recipe_book/models/recipe.dart';

class RecipesService {
  // In the future this class will be use to connect the backend
  List recipes = [
    RecipeModel(
        id: 1,
        title: "Burritos",
        description: "Incredible mexican dish",
        ingredients: [
          "meat",
          "wraps"
        ],
        steps: [
          "open the wrap",
          "put the meat into the wrap"
        ],
      imagePath: "lib/images/Burritos.jpeg"
    ),
    RecipeModel(
        id: 2,
        title: "Pancakes",
        description: "Incredible french dish",
        ingredients: [
          "milk",
          "nutella"
        ],
        steps: [
          "cook pancakes",
          "put a lot of nutella and enjoyyyyy"
        ],
      imagePath: "lib/images/crepes.jpg"
    ),
    RecipeModel(
        id: 3,
        title: "Pierogi",
        description: "Incredible polish dish",
        ingredients: [
          "pierogi"
        ],
        steps: [
          "Idk"
        ],
      imagePath: "lib/images/pierogi.jpg"
    ),
  ];

  List getAllRecipes() {
    return recipes;
  }

  RecipeModel getRecipe(int id) {
    return recipes[id];
  }

  void deleteRecipe(int id) {
    recipes.removeAt(id);
  }
}