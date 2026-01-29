class RecipeModel {
  int id;
  String title;
  String description;
  List ingredients;
  List steps;
  String imagePath;

  RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.imagePath
  });
}