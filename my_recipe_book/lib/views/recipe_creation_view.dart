import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCreationView extends StatelessWidget{

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();


  RecipeCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Recipe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Padding(padding: const EdgeInsets.all(8),
      child: Column(children: [
        TextField(
          controller: _titleController, 
          decoration: const InputDecoration(hintText: 'Title'),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
        ),

        const SizedBox(height: 16),

        TextField(
          controller: _descriptionController, 
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Description', 
            hintText: 'Description',
            border: OutlineInputBorder(),
            alignLabelWithHint: true)),

        const SizedBox(height: 16),

        TextField(
          controller: _ingredientsController, 
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'Ingredients',
            border: OutlineInputBorder())),

        const SizedBox(height: 16),

        TextField(
          controller: _stepsController, 
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'Steps',
            border: OutlineInputBorder())),

        const SizedBox(height: 32),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary),
          onPressed: () {

            final String title = _titleController.text;
            final String description = _descriptionController.text;

            final List<String> ingredients = _ingredientsController.text
              .split('\n').map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();

            final List<String> steps = _stepsController.text
              .split('\n')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();

          if (title.trim().isEmpty) { 
            ScaffoldMessenger.of(context).showSnackBar( 
              SnackBar(content: Text("Please enter a title")), 
              );
            return; 
          } 
               
          if (ingredients.isEmpty) { 
            ScaffoldMessenger.of(context).showSnackBar( 
              SnackBar(content: Text("Please add at least one ingredient")), 
            ); 
            return; 
          } 
          
          if (steps.isEmpty) { 
            ScaffoldMessenger.of(context).showSnackBar( 
              SnackBar(content: Text("Please add at least one step")), 
            ); 
            return; 
          }


          final newRecipe = RecipeModel(
              id: DateTime.now().millisecondsSinceEpoch.toInt(),
              title: title,
              description: description,
              ingredients: ingredients,
              steps: steps,
            );
            
          }, 
          child: const Text('Save')),
      ],)
      )

    );
  }
}