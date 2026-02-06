import 'package:flutter/material.dart';
import 'package:my_recipe_book/view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeCreationView extends StatefulWidget {
  const RecipeCreationView({super.key});

  @override
  State<RecipeCreationView> createState() => _RecipeCreationViewState();
}

class _RecipeCreationViewState extends State<RecipeCreationView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();

  String? _imagePath;

  bool _isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.home, size: 24),
        ),
        title: const Text('Create New Recipe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _imagePath == null
                    ? Image.asset(
                        'lib/images/placeholder.jpg',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(_imagePath!),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),

              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Title'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _ingredientsController,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Ingredients',
                  hintText: 'Ingredients',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _stepsController,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Steps',
                  hintText: 'Steps',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () async {
                  final String title = _titleController.text;
                  final String description = _descriptionController.text;

                  final List<String> ingredients = _ingredientsController.text
                      .split('\n')
                      .map((e) => e.trim())
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
                      SnackBar(
                        content: Text("Please add at least one ingredient"),
                      ),
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
                    imagePath: _imagePath ?? 'lib/images/placeholder.jpg',
                  );

                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    final api = context.read<ApiService>();

                    await api.post('/recipes/create', data: newRecipe.toJson());

                    if (!context.mounted) return;

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Recipe created successfully!"),
                      ),
                    );
                    context.read<HomeViewModel>().addRecipe(newRecipe);
                  } catch (e) {
                    if (!context.mounted) return;

                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error: $e")));
                  }
                },

                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}