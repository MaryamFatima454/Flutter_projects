import 'package:flutter/material.dart';
import '../models/post.dart';

class PostProvider extends ChangeNotifier {
  final List<Post> _posts = [];

  List<Post> get posts => _posts;

  void addPost(Post post) {
    _posts.insert(0, post); 
    notifyListeners();
  }
}
