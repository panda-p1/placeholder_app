import 'package:flutter/material.dart';
import 'package:placeholder_app/core/routes/post_details.dart';
import 'package:placeholder_app/core/routes/post_list.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/screens/post_list_view/post_list.dart';
import 'package:placeholder_app/screens/user_details_screen/view/widgets/bloc_view.dart';
import 'package:placeholder_app/screens/widgets/block_title_text_view.dart';
import 'package:placeholder_app/screens/widgets/shorted_post_view.dart';

class UserDetailsScreenPostListView extends StatelessWidget {
  const UserDetailsScreenPostListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: BlockTitleTextView('Posts',),
        ),
        UserDetailsScreenFeatureBlocView<Post>(
          onSeeMorePressed: (posts) => onSeeMorePressed(context, posts),
          itemsQuantity: 3,
          itemsBuilder: (_,posts) => Column(
            children: posts.map((post) => ShortedPostView(post,
              margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              onPressed: () => onPostPressed(context, post),
            )).toList(),
          ),
        ),
      ],
    );
  }

  void onPostPressed(BuildContext context, Post post) {
    Navigator.pushNamed(context, const PostDetailsRoute().name, arguments: post);
  }

  void onSeeMorePressed(BuildContext context, List<Post> posts) {
    Navigator.pushNamed(context, const PostListRoute().name, arguments: posts);
  }
}
