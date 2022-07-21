import 'package:placeholder_app/data/comment/comment.dart';

class CommentParser {
  const CommentParser._();

  static Comment parse(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}