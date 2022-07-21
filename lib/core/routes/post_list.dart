import 'package:flutter/material.dart';
import 'package:placeholder_app/core/routes/routes.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/screens/post_list_view/post_list.dart';

class PostListRoute extends AppRoute {
  const PostListRoute();

  @override
  WidgetBuilder get builder => (context) {
    final posts = ModalRoute.of(context)!.settings.arguments as List<Post>;
    return PostListScreenView(posts);
  };

  @override
  String get name => "post_list";
}