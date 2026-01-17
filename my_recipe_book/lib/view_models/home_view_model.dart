import 'package:flutter/material.dart';
import 'package:my_recipe_book/models/recipe.dart';
import 'package:my_recipe_book/repositories/recipes_repository.dart';


class HomeViewModel extends ChangeNotifier {
  RecipesRepository recipesRepository;

  HomeViewModel(this.recipesRepository);

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
        ]
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
        ]
    ),
  ];

  void addRecipe() {
    //TODO
  }

  void deleteRecipe() {
    //TODO
  }
}