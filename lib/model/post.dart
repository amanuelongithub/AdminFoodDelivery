
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String content;
  final String description;
  final String price;
  final String uid;
  final String postId;
  final datePublished;
  final String postUrl;
  final rate;
  const Post({
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.title,
    required this.content,
    required this.price,
    required this.uid,
    this.rate,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "uid": uid,
        "title": title,
        "content": content,
        "price": price,
        "rate": rate,
      };
}
