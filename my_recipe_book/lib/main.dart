import 'package:flutter/material.dart';
import 'package:my_recipe_book/repositories/recipes_repository.dart';
import 'package:my_recipe_book/services/api_service.dart';
import 'package:my_recipe_book/view_models/home_view_model.dart';
import 'package:my_recipe_book/views/home_screen.dart';
import 'package:my_recipe_book/views/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ApiService apiService = ApiService();

  final RecipesRepository recipesRepository = RecipesRepository(apiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_) => HomeViewModel(recipesRepository),
        ),
        Provider<ApiService>.value(value: apiService),
        Provider<RecipesRepository>.value(value: recipesRepository),
      ],
      child: const MyRecipeBook(),
    )
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