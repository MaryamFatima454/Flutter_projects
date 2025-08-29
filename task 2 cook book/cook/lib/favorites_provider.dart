import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void toggleFavorite(Map<String, dynamic> recipe) {
    if (_favorites.any((fav) => fav["title"] == recipe["title"])) {
      _favorites.removeWhere((fav) => fav["title"] == recipe["title"]);
    } else {
      _favorites.add(recipe);
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> recipe) {
    return _favorites.any((fav) => fav["title"] == recipe["title"]);
  }
}
