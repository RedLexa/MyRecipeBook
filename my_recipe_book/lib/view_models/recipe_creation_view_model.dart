import 'package:flutter/material.dart';
import '../repositories/recipes_repository.dart';
import '../models/recipe.dart';

class RecipeCreationViewModel extends ChangeNotifier {
  final RecipesRepository recipesRepository;
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  RecipeCreationViewModel(this.recipesRepository);

  Future<bool> createRecipe(RecipeModel recipe) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      // You need to implement addRecipe in RecipesRepository
      await recipesRepository.addRecipe(recipe);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
