import 'all_recipes.dart';

final dessertRecipes =
allRecipes.where((recipe) => recipe.category == "Dessert").toList();
