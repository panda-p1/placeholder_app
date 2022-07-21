import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/data/user/user.dart';

class PostParser {
  const PostParser._();

  static Post parse(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}