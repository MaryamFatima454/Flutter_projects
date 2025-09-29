import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../favorites_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _sortOption = "A→Z";

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    List<Map<String, dynamic>> favorites = List.from(favoritesProvider.favorites);

    // Apply sorting
    favorites.sort((a, b) {
      switch (_sortOption) {
        case "Rating high→low":
          return (b["rating"] ?? 0).compareTo(a["rating"] ?? 0);
        case "Time low→high":
          return int.tryParse(a["time"].replaceAll(RegExp(r'[^0-9]'), ''))!
              .compareTo(int.tryParse(b["time"].replaceAll(RegExp(r'[^0-9]'), ''))!);
        case "A→Z":
        default:
          return a["title"].toString().compareTo(b["title"].toString());
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text("Favorites"),
        actions: [
          DropdownButton<String>(
            value: _sortOption,
            dropdownColor: Colors.black,
            underline: const SizedBox(),
            icon: const Icon(Icons.sort, color: Colors.white),
            items: const [
              DropdownMenuItem(value: "A→Z", child: Text("A→Z", style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: "Rating high→low", child: Text("Rating high→low", style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: "Time low→high", child: Text("Time low→high", style: TextStyle(color: Colors.white))),
            ],
            onChanged: (value) {
              setState(() => _sortOption = value!);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {}); // just re-trigger build
        },
        child: favorites.isEmpty
            ? const Center(
          child: Text("No favorites yet!",
              style: TextStyle(color: Colors.white70, fontSize: 16)),
        )
            : Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: favorites.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.78,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final recipe = favorites[index];
              return _buildFavoriteCard(recipe, favoritesProvider);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> recipe, FavoritesProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  recipe["image"],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () => provider.toggleFavorite(recipe),
                  child: const Icon(Icons.favorite, color: Colors.red, size: 22),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe["title"],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.orange, size: 14),
                    const SizedBox(width: 2),
                    Text(recipe["time"],
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 2),
                    Text("${recipe["rating"] ?? "0.0"}",
                        style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
