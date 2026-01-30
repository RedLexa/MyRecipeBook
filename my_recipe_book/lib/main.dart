import 'package:flutter/material.dart';
import 'package:my_recipe_book/repositories/recipes_repository.dart';
import 'package:my_recipe_book/services/recipes_service.dart';
import 'package:my_recipe_book/view_models/home_view_model.dart';
import 'package:my_recipe_book/views/home_screen.dart';
import 'package:my_recipe_book/views/login_screen.dart';
import 'package:my_recipe_book/views/recipe_creation_view.dart';
import 'package:provider/provider.dart';

void main() {

  final RecipesService recipesService = RecipesService();

  final RecipesRepository recipesRepository = RecipesRepository(recipesService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeViewModel(recipesRepository),
      child: const MyRecipeBook(),
    ),
  );
}

class MyRecipeBook extends StatelessWidget {
  const MyRecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}