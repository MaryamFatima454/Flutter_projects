import 'all_recipes.dart';

final dinnerRecipes =
allRecipes.where((recipe) => recipe.category == "Dinner").toList();
