import 'package:flutter/material.dart';

class EditRecipePage extends StatefulWidget {
  final Map<String, dynamic> recipe;
  const EditRecipePage({super.key, required this.recipe});

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late List<String> ingredients;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.recipe["title"]);
    descriptionController = TextEditingController(text: widget.recipe["description"]);
    ingredients = List<String>.from(widget.recipe["ingredients"] ?? []);
  }

  void saveRecipe() {
    final updatedRecipe = {
      ...widget.recipe,
      "title": titleController.text,
      "description": descriptionController.text,
      "ingredients": ingredients,
    };
    Navigator.pop(context, updatedRecipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Recipe"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveRecipe,
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Recipe Title",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2)),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2)),
              ),
            ),
            const SizedBox(height: 20),

            const Text("Ingredients",
                style: TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold)),
            ...ingredients.asMap().entries.map((entry) {
              final index = entry.key;
              final ingredient = entry.value;
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: ingredient),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (val) {
                        ingredients[index] = val;
                      },
                      decoration: const InputDecoration(
                        hintText: "Ingredient",
                        hintStyle: TextStyle(color: Colors.white54),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange, width: 2)),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        ingredients.removeAt(index);
                      });
                    },
                  )
                ],
              );
            }),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  ingredients.add("");
                });
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Ingredient"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
