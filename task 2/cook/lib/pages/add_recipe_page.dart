import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedCategory;
  String _difficulty = "Easy";
  double _rating = 3.0;

  final List<Map<String, String>> _ingredients = [
    {"name": "", "qty": ""}
  ];

  final List<String> _tags = [];
  final TextEditingController _tagController = TextEditingController();

  final List<String> _categories = ["Breakfast", "Lunch", "Dinner", "Snack"];

  bool _isVegetarian = false;
  bool _isGlutenFree = false;
  bool _isFavorite = false;

  void _addIngredient() {
    setState(() {
      _ingredients.add({"name": "", "qty": ""});
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _addTag() {
    if (_tagController.text.isNotEmpty) {
      setState(() {
        _tags.add(_tagController.text.trim());
        _tagController.clear();
      });
    }
  }

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Recipe Saved! ✅")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form is invalid ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Add Recipe", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: _saveForm,
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Title
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Recipe Title *"),
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: _inputDecoration("Description"),
              ),
              const SizedBox(height: 16),

              // Category
              DropdownButtonFormField<String>(
                dropdownColor: Colors.black,
                value: _selectedCategory,
                items: _categories
                    .map((cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(cat,
                      style: const TextStyle(color: Colors.white)),
                ))
                    .toList(),
                decoration: _inputDecoration("Category"),
                onChanged: (val) => setState(() => _selectedCategory = val),
              ),
              const SizedBox(height: 16),

              // Cook Time
              TextFormField(
                controller: _timeController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Cook Time (minutes) *"),
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Servings
              TextFormField(
                controller: _servingsController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Servings"),
              ),
              const SizedBox(height: 16),

              // Difficulty
              const Text("Difficulty", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                fillColor: Colors.purple,
                selectedColor: Colors.white,
                color: Colors.grey,
                isSelected: [
                  _difficulty == "Easy",
                  _difficulty == "Medium",
                  _difficulty == "Hard"
                ],
                onPressed: (index) {
                  setState(() {
                    _difficulty =
                    index == 0 ? "Easy" : index == 1 ? "Medium" : "Hard";
                  });
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Easy"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Medium"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Hard"),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Image URL
              TextFormField(
                controller: _imageController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Image URL (optional)"),
              ),
              const SizedBox(height: 16),

              // Rating
              Text("Rating: ${_rating.toStringAsFixed(1)}",
                  style: const TextStyle(color: Colors.white)),
              Slider(
                value: _rating,
                min: 0,
                max: 5,
                divisions: 10,
                label: _rating.toStringAsFixed(1),
                activeColor: Colors.purple,
                onChanged: (val) => setState(() => _rating = val),
              ),
              const SizedBox(height: 16),

              // Ingredients
              const Text("Ingredients *",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Column(
                children: _ingredients.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: entry.value["name"],
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Name"),
                          onChanged: (val) =>
                          _ingredients[index]["name"] = val,
                          validator: (value) =>
                          value == null || value.isEmpty ? "Required" : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 80,
                        child: TextFormField(
                          initialValue: entry.value["qty"],
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Qty"),
                          onChanged: (val) => _ingredients[index]["qty"] = val,
                          validator: (value) =>
                          value == null || value.isEmpty ? "Required" : null,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeIngredient(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _addIngredient,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.purple),
                  foregroundColor: Colors.purple,
                ),
                icon: const Icon(Icons.add),
                label: const Text("Add Ingredient"),
              ),
              const SizedBox(height: 16),

              // Steps / Instructions
              TextFormField(
                controller: _stepsController,
                style: const TextStyle(color: Colors.white),
                maxLines: 5,
                decoration: _inputDecoration("Instructions / Steps"),
              ),
              const SizedBox(height: 16),

              // Tags
              const Text("Tags", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _tags.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Chip(
                    label: Text(entry.value),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => _removeTag(index),
                    backgroundColor: Colors.purple.shade300,
                  );
                }).toList(),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tagController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration("Add Tag"),
                    ),
                  ),
                  IconButton(
                    onPressed: _addTag,
                    icon: const Icon(Icons.add, color: Colors.purple),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Switches (Options)
              SwitchListTile(
                title: const Text("Vegetarian",
                    style: TextStyle(color: Colors.white)),
                value: _isVegetarian,
                onChanged: (val) => setState(() => _isVegetarian = val),
                activeColor: Colors.purple,
              ),
              SwitchListTile(
                title: const Text("Gluten Free",
                    style: TextStyle(color: Colors.white)),
                value: _isGlutenFree,
                onChanged: (val) => setState(() => _isGlutenFree = val),
                activeColor: Colors.purple,
              ),
              SwitchListTile(
                title: const Text("Mark as Favorite",
                    style: TextStyle(color: Colors.white)),
                value: _isFavorite,
                onChanged: (val) => setState(() => _isFavorite = val),
                activeColor: Colors.purple,
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _notesController,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                decoration: _inputDecoration("Extra Notes"),
              ),
              const SizedBox(height: 24),

              // Save Button (Bottom)
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _saveForm,
                  icon: const Icon(Icons.save),
                  label: const Text("Save Recipe"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.purple),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
