import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post.dart';
import 'add_post_page.dart';
import 'post_detail_page.dart';

class ProfilePage extends StatefulWidget {
  final String userName;

  const ProfilePage({super.key, required this.userName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Post> profilePosts = [];
  File? profileImageFile;

  final ImagePicker _picker = ImagePicker();

  // Pick profile image
  Future<void> _pickProfileImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImageFile = File(image.path);
      });
    }
  }

  // Show options when profile image tapped
  void _onProfileImageTap() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: const Text("View Picture"),
              onTap: () {
                Navigator.pop(context);
                if (profileImageFile != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullImageView(
                        imageFile: profileImageFile!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No profile picture selected")),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Picture"),
              onTap: () {
                Navigator.pop(context);
                _pickProfileImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openAddPost() async {
    final newPost = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPostPage()),
    );

    if (newPost != null && newPost is Post) {
      final choice = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add Post"),
          content: const Text("Where do you want to show this post?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, "Home"),
              child: const Text("Home"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, "Profile"),
              child: const Text("Profile"),
            ),
          ],
        ),
      );

      if (choice == "Profile") {
        setState(() {
          profilePosts.insert(0, newPost);
        });
      } else if (choice == "Home") {
        Navigator.pop(context, newPost);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onBackground),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: theme.colorScheme.onBackground),
            onSelected: (value) {
              if (value == "add_post") {
                _openAddPost();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "add_post",
                child: Text("Add Post"),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? null
              : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB3E5FC),
              Color(0xFFE1BEE7),
              Color(0xFFF8BBD0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Image with options
                GestureDetector(
                  onTap: _onProfileImageTap,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImageFile != null
                            ? FileImage(profileImageFile!)
                            : const AssetImage("assets/profile.jpg")
                        as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  widget.userName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "@${widget.userName}",
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _StatItem(count: "127", label: "Posts"),
                    _StatItem(count: "2.4K", label: "Likes"),
                    _StatItem(count: "15.2K", label: "Views"),
                  ],
                ),
                const SizedBox(height: 25),

                if (profilePosts.isNotEmpty)
                  Column(
                    children: profilePosts.asMap().entries.map((entry) {
                      int index = entry.key;
                      Post post = entry.value;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailPage(post: post),
                            ),
                          );
                        },
                        child: _PostCard(
                          index: index + 1,
                          name: post.name,
                          time: post.timeAgo,
                          text: post.text,
                          likes: post.likes.toString(),
                          comments: post.comments.length.toString(),
                          shares: post.shares.toString(),
                          thumbnail: post.thumbnail,
                          profileImage: profileImageFile != null
                              ? profileImageFile!.path
                              : post.profileImage,
                        ),
                      );
                    }).toList(),
                  )
                else
                  Text(
                    "No posts yet",
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- Full Image View ----------------
class FullImageView extends StatelessWidget {
  final File imageFile;

  const FullImageView({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(imageFile),
        ),
      ),
    );
  }
}

// ----------------- Stat Item -----------------
class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: theme.textTheme.bodySmall?.color,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// ----------------- Post Card -----------------
class _PostCard extends StatelessWidget {
  final int index;
  final String name;
  final String time;
  final String text;
  final String likes;
  final String comments;
  final String shares;
  final String? thumbnail;
  final dynamic profileImage;

  const _PostCard({
    required this.index,
    required this.name,
    required this.time,
    required this.text,
    required this.likes,
    required this.comments,
    required this.shares,
    this.thumbnail,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ImageProvider profilePicProvider;
    if (profileImage != null) {
      if (profileImage is String && profileImage.startsWith("http")) {
        profilePicProvider = NetworkImage(profileImage);
      } else if (profileImage is String) {
        profilePicProvider = FileImage(File(profileImage));
      } else if (profileImage is File) {
        profilePicProvider = FileImage(profileImage);
      } else {
        profilePicProvider = const AssetImage("assets/profile.jpg");
      }
    } else {
      profilePicProvider = const AssetImage("assets/profile.jpg");
    }

    return Card(
      color: theme.cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "$index.",
                  style: TextStyle(
                    color: theme.colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 18,
                  backgroundImage: profilePicProvider,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: theme.textTheme.bodySmall?.color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.more_vert, color: theme.iconTheme.color),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(
                color: theme.colorScheme.onBackground,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            if (thumbnail != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  thumbnail!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ActionItem(icon: Icons.favorite, count: likes, color: Colors.red),
                _ActionItem(icon: Icons.comment, count: comments),
                _ActionItem(icon: Icons.share, count: shares),
                Icon(Icons.bookmark_border, color: theme.iconTheme.color, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- Action Item -----------------
class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String count;
  final Color? color;

  const _ActionItem({required this.icon, required this.count, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: color ?? theme.iconTheme.color, size: 18),
        const SizedBox(width: 4),
        Text(
          count,
          style: TextStyle(color: theme.textTheme.bodySmall?.color, fontSize: 13),
        ),
      ],
    );
  }
}
