class Post {
  // Basic info
  final String name;
  final String time;
  final String text;

  // Details
  String title;
  String body;
  String category;
  String thumbnailUrl;
  String source;
  String timeAgo;

  // Stats
  int views;
  int likes;
  int shares;
  List<String> comments;
  List<String> tags;
  final String? thumbnail; // post image
  final String? profileImage; // user profile image

  Post({
    // From second model
    required this.name,
    required this.time,
    required this.text,

    // From first model
    required this.title,
    required this.body,
    required this.category,
    required this.thumbnailUrl,
    required this.source,
    required this.timeAgo,

    // Stats with defaults
    this.thumbnail,
    this.profileImage,
    this.views = 0,
    this.likes = 0,
    this.shares = 0,
    List<String>? comments,
    List<String>? tags,
  })  : comments = comments ?? [],
        tags = tags ?? [];
}
