import 'all_recipes.dart';

final breakfastRecipes =
allRecipes.where((recipe) => recipe.category == "Breakfast").toList();
