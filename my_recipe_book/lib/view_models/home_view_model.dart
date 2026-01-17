import 'package:flutter/material.dart';
import 'package:my_recipe_book/repositories/recipes_repository.dart';


class HomeViewModel extends ChangeNotifier {
  RecipesRepository recipesRepository;

  HomeViewModel(this.recipesRepository);

  late List recipes = recipesRepository.getAllRecipes();

  void addRecipe() {
    //TODO
  }

  void deleteRecipe() {
    //TODO
  }
}