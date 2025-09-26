import 'package:flutter/material.dart';
import '../models/post.dart';
import 'post_detail_page.dart';

class SearchPage extends StatefulWidget {
  final List<Post> posts;
  const SearchPage({super.key, required this.posts});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Post> _filteredPosts = [];
  String _selectedCategory = "All Stories";

  final List<String> categories = [
    "All Stories",
    "Technology",
    "Business",
    "Health",
    "Science",
    "Sports"
  ];

  @override
  void initState() {
    super.initState();
    _filteredPosts = widget.posts;
  }

  void _searchPosts(String query) {
    setState(() {
      _filteredPosts = widget.posts.where((post) {
        final matchesQuery = post.title.toLowerCase().contains(query.toLowerCase()) ||
            post.body.toLowerCase().contains(query.toLowerCase());
        final matchesCategory = _selectedCategory == "All Stories" ||
            post.category == _selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _searchPosts(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textColor = colorScheme.onBackground;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 App Bar with Back + Search
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        hintText: "Search stories...",
                        hintStyle: TextStyle(
                          color: textColor.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: _searchPosts,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Category Chips
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) => _filterByCategory(category),
                      selectedColor: colorScheme.primary,
                      backgroundColor: colorScheme.surfaceVariant,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Post List (without image)
            Expanded(
              child: _filteredPosts.isEmpty
                  ? Center(
                child: Text(
                  "No posts found",
                  style: TextStyle(
                    color: textColor.withOpacity(0.6),
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: _filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = _filteredPosts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostDetailPage(post: post),
                        ),
                      );
                    },
                    child: Card(
                      color: colorScheme.surface,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 Title
                            Text(
                              post.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // 🔹 Source + Time
                            Row(
                              children: [
                                Text(
                                  post.source,
                                  style: TextStyle(
                                      color:
                                      textColor.withOpacity(0.5),
                                      fontSize: 12),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "• ${post.timeAgo}",
                                  style: TextStyle(
                                      color:
                                      textColor.withOpacity(0.5),
                                      fontSize: 12),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // 🔹 Category + Views
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(
                                        post.category),
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    post.category,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Icon(Icons.remove_red_eye,
                                    size: 16,
                                    color:
                                    textColor.withOpacity(0.5)),
                                const SizedBox(width: 4),
                                Text(
                                  "${post.views}",
                                  style: TextStyle(
                                      color:
                                      textColor.withOpacity(0.5),
                                      fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🔹 Category colors
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'technology':
        return Colors.blue;
      case 'business':
        return Colors.green;
      case 'health':
        return Colors.red;
      case 'science':
        return Colors.purple;
      case 'sports':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
