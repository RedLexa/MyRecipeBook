import 'package:flutter/material.dart';
import 'package:my_recipe_book/models/recipe.dart';
import 'package:my_recipe_book/repositories/recipes_repository.dart';


class HomeViewModel extends ChangeNotifier {
  final RecipesRepository _recipesRepository;

  List<RecipeModel> _recipes = [];

  HomeViewModel(this._recipesRepository) {
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    _recipes = await _recipesRepository.getAllRecipes("alice");
    notifyListeners();
  }

  List<RecipeModel> get recipes => _recipes;





  //void deleteRecipe(int id) {
    //_recipesRepository.deleteRecipe(id);
    //notifyListeners();
  //}
}