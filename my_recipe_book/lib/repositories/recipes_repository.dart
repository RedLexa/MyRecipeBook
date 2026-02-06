
import 'package:dio/dio.dart';
import 'package:my_recipe_book/models/recipe.dart';
import '../models/api_response.dart';
import '../services/api_service.dart';
import 'package:flutter/foundation.dart';

class RecipesRepository {
  final ApiService _apiService;

  RecipesRepository(this._apiService);

  Future<List<RecipeModel>> getAllRecipes(String username) async {
    try {
      final response = await _apiService.get('/recipes/all/$username');

      final apiResponse = ApiResponse<List<RecipeModel>>.fromJson(
        response as Map<String, dynamic>,
        (data) => (data as List)
            .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      if (!apiResponse.success) {
        debugPrint('API error: \\nCode: \\${apiResponse.error?.code}\\nMessage: \\${apiResponse.error?.message}');
        throw ApiException.fromApiError(apiResponse.error!);
      }

      return apiResponse.data!;
    } on DioException catch (e) {
      debugPrint('DioException in getAllRecipes: \\nType: \\${e.type}\\nMessage: \\${e.message}\\nResponse: \\${e.response}');
      throw _handleDioError(e);
    } catch (e, stack) {
      debugPrint('Unexpected error in getAllRecipes: \\nError: \\${e.toString()}\\nStack: \\${stack.toString()}');
      rethrow;
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      final response = await _apiService.delete('/recipes/delete/$id');

      final apiResponse = ApiResponse<void>.fromJson(
        response as Map<String, dynamic>,
        (data) {},
      );

      if (!apiResponse.success) {
        throw ApiException.fromApiError(apiResponse.error!);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<RecipeModel> getRecipeById(int id) async {
    try {
      final response = await _apiService.get('/recipes/$id');

      final apiResponse = ApiResponse<RecipeModel>.fromJson(
        response as Map<String, dynamic>,
        (data) => RecipeModel.fromJson(data as Map<String, dynamic>),
      );

      if (!apiResponse.success) {
        throw ApiException.fromApiError(apiResponse.error!);
      }

      return apiResponse.data!;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> addRecipe(RecipeModel recipe) async {
    try {
      final response = await _apiService.post('/recipes/create', data: recipe.toJson());

      final apiResponse = ApiResponse<void>.fromJson(
        response as Map<String, dynamic>,
        null,
      );

      if (!apiResponse.success) {
        throw ApiException.fromApiError(apiResponse.error!);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ApiException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException.timeout();

      case DioExceptionType.connectionError:
        return ApiException.network(
          'Unable to connect to server. Check your internet connection.',
        );

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;

        if (data is Map<String, dynamic> && data['error'] != null) {
          final apiError = ApiError.fromJson(data['error'] as Map<String, dynamic>);
          return ApiException.fromApiError(apiError, statusCode: statusCode);
        }

        return ApiException(
          message: 'Server error occurred',
          statusCode: statusCode,
          code: 'SERVER_ERROR',
        );

      case DioExceptionType.cancel:
        return const ApiException(
          message: 'Request was cancelled',
          code: 'CANCELLED',
        );

      default:
        return ApiException.network('An unexpected error occurred');
    }
  }
}