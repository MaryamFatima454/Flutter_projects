import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/post.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? Colors.black 
          : const Color(0xFFE3F2FD), 
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : const Color(0xFF90CAF9),
        elevation: 0,
        title: Text(
          "Daily Stories",
          style: GoogleFonts.poppins(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: isDark ? Colors.white : Colors.black),
            onPressed: () {
           
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Row(
                children: [
                  Icon(Icons.favorite,
                      size: 18, color: isDark ? Colors.white : Colors.black),
                  const SizedBox(width: 4),
                  Text(
                    "${post.likes}",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.comment,
                      size: 18, color: isDark ? Colors.white : Colors.black),
                  const SizedBox(width: 4),
                  Text(
                    "${post.comments.length}",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.remove_red_eye,
                      size: 18, color: isDark ? Colors.white : Colors.black),
                  const SizedBox(width: 4),
                  Text(
                    "${post.views}",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                post.title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                post.body,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              Wrap(
                spacing: 6,
                children: post.tags
                    .map((tag) => Chip(
                  label: Text(tag),
                  backgroundColor:
                  isDark ? Colors.blueAccent : Colors.lightBlue,
                  labelStyle:
                  const TextStyle(color: Colors.white),
                ))
                    .toList(),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                   
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor:
                        isDark ? Colors.grey[900] : Colors.white,
                        title: Text(
                          "Delete Post",
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black),
                        ),
                        content: Text(
                          "Are you sure you want to delete this post?",
                          style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black87),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel",
                                style: TextStyle(
                                    color:
                                    isDark ? Colors.white : Colors.black)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); 
                              Navigator.pop(context,
                                  true);
                            },
                            child: const Text("Delete",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text(
                    "Delete Post",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
