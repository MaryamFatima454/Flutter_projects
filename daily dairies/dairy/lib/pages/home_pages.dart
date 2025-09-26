import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme/theme_notifier.dart';
import '../models/post.dart';
import 'quotes_page.dart';
import 'profile_page.dart';
import 'add_post_page.dart';
import 'search_page.dart';
import 'login_page.dart';
import 'post_detail_page.dart'; // 👈 detail page import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  List<Post> posts = [
    Post(
      name: "Admin",
      time: DateTime.now().toString(),
      text: "AI is reshaping modern society.",
      title: "The Future of Artificial Intelligence in Modern Society",
      body:
      "Exploring how AI is transforming and reshaping the way we work, communicate, and live our daily lives in the digital age.",
      category: "Technology",
      thumbnailUrl: "https://example.com/ai.jpg",
      source: "TechCrunch",
      timeAgo: "2h ago",
      views: 2100,
      likes: 142,
      comments: ["Great article!", "Interesting!"],
      tags: ["Technology", "AI", "Future"],
    ),
    Post(
      name: "EcoWriter",
      time: DateTime.now().subtract(const Duration(hours: 4)).toString(),
      text: "We must act now against climate change.",
      title: "Climate Change Solutions: What Can We Do Today?",
      body:
      "Practical steps and innovative technologies that individuals and communities can adopt to combat climate change and create a better future.",
      category: "Environment",
      thumbnailUrl: "https://example.com/climate.jpg",
      source: "EcoWatch",
      timeAgo: "4h ago",
      views: 1500,
      likes: 89,
      comments: ["Very useful!", "Eye opener"],
      tags: ["Environment", "Climate"],
    ),
    Post(
      name: "LifeGuru",
      time: DateTime.now().subtract(const Duration(hours: 7)).toString(),
      text: "Minimalism brings peace of mind.",
      title: "The Art of Minimalist Living: Less is More",
      body:
      "Discover how embracing minimalism can lead to a more fulfilling life, reduced stress, and increased focus on what truly matters.",
      category: "Lifestyle",
      thumbnailUrl: "https://example.com/minimalism.jpg",
      source: "LifeWell",
      timeAgo: "7h ago",
      views: 3200,
      likes: 256,
      comments: ["Loved this!", "Nice tips"],
      tags: ["Lifestyle", "Minimalism", "Wellness"],
    ),
  ];

  void _navigateToAddPost() async {
    final newPost = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPostPage()),
    );

    if (newPost != null && newPost is Post) {
      setState(() {
        posts.insert(0, newPost);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily Stories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDark ? Colors.black : Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddPost,
          ),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchPage(posts: posts),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? null
              : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB3E5FC), // Light sky blue
              Color(0xFFE1BEE7), // Soft purple
              Color(0xFFF8BBD0), // Light pink
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: isDark
                  ? Colors.grey.shade900
                  : Colors.white.withOpacity(0.5),
              child: Text(
                "Welcome, ${user?.email?.split('@')[0] ?? 'User'} 👋",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: posts.isEmpty
                  ? const Center(child: Text("No posts yet"))
                  : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return InkWell(
                    onTap: () async {
                      final deleted = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PostDetailPage(post: posts[index]),
                        ),
                      );

                      if (deleted == true) {
                        setState(() {
                          posts.removeAt(index); // ✅ delete from list
                        });
                      }
                    },
                    child: PostCard(
                      post: post,
                      onLike: () {
                        setState(() {
                          post.likes++;
                        });
                      },
                      onComment: (String newComment) {
                        setState(() {
                          post.comments.add(newComment);
                        });
                      },
                      onView: () {
                        setState(() {
                          post.views++;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) async {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuotesPage()),
            );
          } else if (index == 2) {
            final email = user?.email ?? "guest@gmail.com";
            final userName = email.split('@')[0];

            final result = await Navigator.push<Post?>(
              context,
              MaterialPageRoute(
                builder: (_) => ProfilePage(userName: userName),
              ),
            );

            if (result != null && result is Post) {
              setState(() {
                posts.insert(0, result);
              });
            }
          }
        },
        backgroundColor: isDark ? Colors.black : Colors.white.withOpacity(0.7),
        selectedItemColor: isDark ? Colors.white : Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: "Quotes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback onLike;
  final Function(String) onComment;
  final VoidCallback onView;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onView,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  final TextEditingController _commentController = TextEditingController();

  final List<Color> _tagColors = const [
    Colors.blue,
    Colors.purple,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.indigo,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.post.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: widget.post.tags.asMap().entries.map((entry) {
                final index = entry.key;
                final tag = entry.value;
                final color = _tagColors[index % _tagColors.length];
                return Chip(
                  label: Text(tag),
                  labelStyle: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                  backgroundColor: color,
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.thumb_up, size: 18, color: Colors.orange),
                const SizedBox(width: 4),
                Text(widget.post.likes.toString()),
                const Spacer(),
                const Icon(Icons.remove_red_eye,
                    size: 18, color: Colors.grey),
                const SizedBox(width: 4),
                Text(widget.post.views.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
