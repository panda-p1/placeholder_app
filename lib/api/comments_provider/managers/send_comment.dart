import 'dart:math';

import 'package:placeholder_app/api/base/base_provider.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/api/comments_provider/requests/send_comment.dart';
import 'package:placeholder_app/data/comment/comment.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_bloc.dart';
import 'package:placeholder_app/screens/send_message_screen/bloc/send_message_screen_bloc.dart';

class SendCommentDetails {
  final String email;
  final String text;
  final String name;

  const SendCommentDetails({
    required this.email,
    required this.text,
    required this.name,
  });
}

abstract class AddComment {
  Post get post;
  void addComment(Comment comment, );
}

class SendCommentNetManager extends CacheableNetManager implements SendCommentRepo {
  final AddComment addComment;
  const SendCommentNetManager({
    required this.addComment,
  });

  @override
  Future<ProviderResponse> sendComment(SendCommentDetails details) async {
    final request = SendCommentRequest(addComment.post.id, sendCommentDetails: details,);
    final response = await fetch(request);
    if(response.isSuccess()) {
      addComment.addComment(_makeComment(details));
    }
    return response;
  }

  Comment _makeComment(SendCommentDetails details) {
    return Comment(
      postId: addComment.post.id,
      id: random(10000, 1000000),
      name: details.name,
      email: details.email,
      body: details.text,
    );
  }

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

}