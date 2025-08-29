class Recipe {
  final String title;
  final String time;
  final int rating;
  final String image;
  final String category;

  Recipe({
    required this.title,
    required this.time,
    required this.rating,
    required this.image,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "time": time,
      "rating": rating,
      "image": image,
      "category": category,
    };
  }
}
