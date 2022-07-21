import 'dart:math';

import 'package:flutter/material.dart';
import 'package:placeholder_app/core/routes/post_details.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/screens/widgets/shorted_post_view.dart';

class PostListScreenView extends StatelessWidget {
  final List<Post> posts;
  const PostListScreenView(this.posts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 16,
          bottom: max(MediaQuery.of(context).padding.bottom, 8),
        ),
        itemExtent: 66,
        children: posts.map((post) => ShortedPostView(post,
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          onPressed: () => onPressed(context, post),
        )).toList(),
      ),
    );
  }

  void onPressed(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(const PostDetailsRoute().name, arguments: post);
  }
}
