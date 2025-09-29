import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../favorites_provider.dart';
import 'edit_recipe_page.dart';

class RecipePage extends StatefulWidget {
  final Map<String, dynamic> recipe;
  const RecipePage({super.key, required this.recipe});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final Map<String, String> selectedQuantities = {};
  bool showInstructions = false;

  late List<String> ingredients;
  Set<String> cutIngredients = {};
  int currentRating = 0;

  late Map<String, dynamic> recipeData;

  @override
  void initState() {
    super.initState();
    recipeData = Map<String, dynamic>.from(widget.recipe);
    ingredients = List<String>.from(recipeData["ingredients"] ?? []);
    currentRating = recipeData["rating"] ?? 0;
  }

  List<String> getFilteredInstructions(List<String> instructions) {
    return instructions.where((step) {
      for (var cut in cutIngredients) {
        if (step.toLowerCase().contains(cut.toLowerCase())) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final instructions = List<String>.from(recipeData["instructions"] ?? []);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, currentRating);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(recipeData["title"], style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context, currentRating);
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with Favorite
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      recipeData["image"],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        favoritesProvider.toggleFavorite(recipeData);
                      },
                      child: Icon(
                        favoritesProvider.isFavorite(recipeData)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 30,
                        color: favoritesProvider.isFavorite(recipeData)
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title + Time
              Text(
                recipeData["title"],
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.orange, size: 18),
                  const SizedBox(width: 5),
                  Text(recipeData["time"],
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 12),

              // Rating
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentRating = index + 1;
                        recipeData["rating"] = currentRating;
                      });
                    },
                    child: Icon(
                      index < currentRating ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      size: 28,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Description
              Text("Description",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              Text(recipeData["description"] ?? "",
                  style: const TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 20),

              // Ingredients
              Text("Ingredients (tap to cut if not needed)",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              ...ingredients.map((item) {
                final isCut = cutIngredients.contains(item);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isCut) {
                        cutIngredients.remove(item);
                      } else {
                        cutIngredients.add(item);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "• $item",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              decoration: isCut
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Qty",
                              hintStyle: const TextStyle(color: Colors.white54),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2)),
                            ),
                            onChanged: (val) {
                              setState(() {
                                selectedQuantities[item] = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              if (showInstructions) ...[
                Text("Instructions",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 8),
                ...getFilteredInstructions(instructions).asMap().entries.map(
                      (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("${e.key + 1}. ${e.value}",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 16)),
                  ),
                ),
              ],
            ],
          ),
        ),

        // ✅ Bottom Buttons
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.black,
          child: Row(
            children: [
              // Edit Recipe Button
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: () async {
                    final updatedRecipe = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditRecipePage(recipe: recipeData)),
                    );

                    if (updatedRecipe != null) {
                      setState(() {
                        recipeData = updatedRecipe;
                        ingredients =
                        List<String>.from(recipeData["ingredients"] ?? []);
                      });
                    }
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text("Edit Recipe",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),

              // Cook Now Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15)),
                  onPressed: () {
                    setState(() {
                      showInstructions = true;
                    });
                  },
                  child: const Text("Cook Now",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
