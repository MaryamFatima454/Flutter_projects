import 'all_recipes.dart';

final lunchRecipes =
allRecipes.where((recipe) => recipe.category == "Lunch").toList();
