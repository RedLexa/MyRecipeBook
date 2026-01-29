import 'package:api_response/api_response.dart';
import 'package:dio/dio.dart';
import 'package:my_recipe_book/models/recipe.dart';
import 'package:my_recipe_book/services/recipes_service.dart';

import '../services/api_service.dart';

class RecipesRepository {
  final ApiService _apiService;

  RecipesRepository(this._apiService);

  Future<List<RecipeModel>> getAllRecipes(String username) async {
    try {
      final response = await _apiService.get('/recipes/all/$username');

      final apiResponse = ApiResponse<List<RecipeModel>>.fromJson(response);

      if (!apiResponse.success) {
        throw ApiException.fromApiError(apiResponse.error);
      }

      return apiResponse.data;
    } on DioException catch (e) {
      throw _handleDioError(e);;
    }
  }
}