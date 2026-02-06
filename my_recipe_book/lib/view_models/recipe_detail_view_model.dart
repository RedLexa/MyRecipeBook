import 'package:flutter/material.dart';
import '../repositories/recipes_repository.dart';
import '../models/recipe.dart';

class RecipeDetailViewModel extends ChangeNotifier {
  final RecipesRepository recipesRepository;
  RecipeModel? _recipe;
  bool _isLoading = false;
  String? _errorMessage;
  RecipeModel? get recipe => _recipe;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  RecipeDetailViewModel(this.recipesRepository);

  void setRecipe(RecipeModel recipe) {
    _recipe = recipe;
    notifyListeners();
  }

  Future<void> fetchRecipe(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _recipe = await recipesRepository.getRecipeById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
