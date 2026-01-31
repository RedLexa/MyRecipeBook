import 'package:flutter/material.dart';
import 'package:my_recipe_book/models/recipe.dart';
import 'package:my_recipe_book/repositories/recipes_repository.dart';

import '../models/api_response.dart';


class HomeViewModel extends ChangeNotifier {
  final RecipesRepository _recipesRepository;

  List<RecipeModel> _recipes = [];
  bool _isLoading = true;
  bool _errorLoading = false;
  String _error = "";
  String _errorMessage = "";
  bool _errorDeleting = false;


  HomeViewModel(this._recipesRepository) {
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      _recipes = await _recipesRepository.getAllRecipes("alice");
      _isLoading = false;
      notifyListeners();
    } on ApiException catch (e) {
      _isLoading = false;
      _errorLoading = true;
      _error = e.code ?? "";
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      await _recipesRepository.deleteRecipe(id);
      _recipes.removeWhere((recipe) => recipe.id == id);
      _errorDeleting = false;
      notifyListeners();
    } on ApiException catch (e) {
      _errorDeleting = true;
      notifyListeners();
    }
  }

  List<RecipeModel> get recipes => _recipes;

  bool get isLoading => _isLoading;

  bool get errorLoading => _errorLoading;

  String get error => _error;

  String get errorMessage => _errorMessage;

  bool get errorDeleting => _errorDeleting;
}






  //void deleteRecipe(int id) {
    //_recipesRepository.deleteRecipe(id);
    //notifyListeners();
  //}
