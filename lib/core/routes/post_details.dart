import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/comments_provider/managers/get_comments.dart';
import 'package:placeholder_app/api/comments_provider/managers/send_comment.dart';
import 'package:placeholder_app/core/routes/routes.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_bloc.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_event.dart';
import 'package:placeholder_app/screens/post_details_screen/view/post_details_screen.dart';

class PostDetailsRoute extends AppRoute {
  const PostDetailsRoute();

  @override
  WidgetBuilder get builder => (context) {
    final post = ModalRoute.of(context)!.settings.arguments as Post;
    return BlocProvider(
      create: (context) => PostDetailsScreenBloc(
        getCommentsRepo: GetCommentsNetManager(post),
        post: post,
      )..add(PostDetailsScreenLoad()),
      child: PostDetailsScreenView(post),
    );
  };

  @override
  String get name => "post_details";
}