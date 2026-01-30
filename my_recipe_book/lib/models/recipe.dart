class RecipeModel {
  int id;
  String title;
  String description;
  List<String> ingredients;
  List<String> steps;
  String imagePath;

  RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.imagePath
  });

  /// Creates a RecipeModel from JSON returned by the API.
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List)
      .map((e) => e as String)
      .toList(),
      steps: (json['steps'] as List)
          .map((e) => e as String)
          .toList(),
      imagePath: json['imagePath'] as String,
    );
  }

  /// Converts the recipes to JSON for API requests.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'steps': steps,
      'imagePath': imagePath,
    };
  }
}