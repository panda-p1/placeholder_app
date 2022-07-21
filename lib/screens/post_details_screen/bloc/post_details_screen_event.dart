import 'package:placeholder_app/api/comments_provider/managers/send_comment.dart';
import 'package:placeholder_app/data/comment/comment.dart';

abstract class PostDetailsScreenEvent {
  const PostDetailsScreenEvent();
}

class PostDetailsScreenLoad extends PostDetailsScreenEvent {}
class PostDetailsScreenAddComment extends PostDetailsScreenEvent {
  final Comment comment;

  const PostDetailsScreenAddComment(this.comment);
}