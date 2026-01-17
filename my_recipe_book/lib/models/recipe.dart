class RecipeModel {
  int id;
  String title;
  String description;
  List ingredients;
  List steps;

  RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps
  });
}