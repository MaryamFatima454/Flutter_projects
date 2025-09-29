import 'package:flutter/material.dart';
import '../models/post.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _thumbnailUrlController =
  TextEditingController();
  final TextEditingController _textController = TextEditingController(); // 👈 Added for `text`

  final List<String> _tags = [];
  String _selectedCategory = 'Technology';

  final List<String> _categories = [
    'Technology',
    'Business',
    'Health',
    'Science',
    'Sports',
  ];

  // 🎨 Tag colors list
  final List<Color> _tagColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
  ];

  void _addTag() {
    if (_tagController.text.trim().isNotEmpty) {
      setState(() {
        _tags.add(_tagController.text.trim());
        _tagController.clear();
      });
    }
  }

  void _savePost() {
    if (_titleController.text.isNotEmpty &&
        _bodyController.text.isNotEmpty &&
        _sourceController.text.isNotEmpty &&
        _thumbnailUrlController.text.isNotEmpty &&
        _textController.text.isNotEmpty) {
      final newPost = Post(
        name: "User",
        time: DateTime.now().toString(),
        text: _textController.text, // 👈 FIXED (required field added)
        title: _titleController.text,
        body: _bodyController.text,
        category: _selectedCategory,
        thumbnailUrl: _thumbnailUrlController.text,
        source: _sourceController.text,
        timeAgo: "Just now",
        views: 0,
        likes: 0,
        comments: [],
        tags: _tags,
      );
      Navigator.pop(context, newPost);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields.")),
      );
    }
  }

  InputDecoration _inputDecoration(
      BuildContext context, String label, String hint) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      labelStyle:
      TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.7)),
      hintText: hint,
      hintStyle:
      TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.4)),
      filled: true,
      fillColor: theme.colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: theme.dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: theme.dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        backgroundColor: isDark ? Colors.black : Colors.transparent,
        foregroundColor: theme.colorScheme.onBackground,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : null,
          gradient: isDark
              ? null
              : const LinearGradient(
            colors: [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                style: TextStyle(color: theme.colorScheme.onBackground),
                decoration:
                _inputDecoration(context, "Title", "Enter post title..."),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bodyController,
                maxLines: 5,
                style: TextStyle(color: theme.colorScheme.onBackground),
                decoration: _inputDecoration(
                    context, "Body", "Write your post content..."),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _textController, // 👈 Added field for `text`
                style: TextStyle(color: theme.colorScheme.onBackground),
                decoration:
                _inputDecoration(context, "Text", "Enter short text..."),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: _inputDecoration(context, "Category", ""),
                items: _categories
                    .map((category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedCategory = value!),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _sourceController,
                style: TextStyle(color: theme.colorScheme.onBackground),
                decoration:
                _inputDecoration(context, "Source", "Enter news source..."),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _thumbnailUrlController,
                style: TextStyle(color: theme.colorScheme.onBackground),
                decoration: _inputDecoration(
                    context, "Thumbnail URL", "Enter image URL..."),
              ),
              const SizedBox(height: 16),
              Text("Tags",
                  style: TextStyle(
                      color: theme.colorScheme.onBackground.withOpacity(0.7))),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 6,
                      children: _tags.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tag = entry.value;
                        final color =
                        _tagColors[index % _tagColors.length]; // 🎨
                        return Chip(
                          label: Text(tag,
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: color,
                          deleteIcon: const Icon(Icons.close,
                              size: 18, color: Colors.white),
                          onDeleted: () =>
                              setState(() => _tags.remove(tag)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _tagController,
                            style: TextStyle(
                                color: theme.colorScheme.onBackground),
                            decoration:
                            _inputDecoration(context, "", "Add a tag..."),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addTag,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text("Add",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _savePost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    "Save Post",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
