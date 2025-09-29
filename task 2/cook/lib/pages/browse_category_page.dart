import 'package:flutter/material.dart';

class BrowseCategoryPage extends StatelessWidget {
  const BrowseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ["Breakfast", "Lunch", "Dinner", "Dessert", "Snacks"];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Browse by Category",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.category, color: Colors.purple),
            title: Text(categories[index],
                style: const TextStyle(color: Colors.white)),
            onTap: () {
              // Later you can navigate to filtered recipe list
            },
          );
        },
      ),
    );
  }
}
