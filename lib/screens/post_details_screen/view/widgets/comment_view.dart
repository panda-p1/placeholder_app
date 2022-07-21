import 'package:flutter/material.dart';
import 'package:placeholder_app/data/comment/comment.dart';
import 'package:placeholder_app/screens/post_details_screen/view/widgets/comment_author_block_view.dart';

class CommentView extends StatelessWidget {
  final Comment comment;
  const CommentView(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentAuthorBlocView(
            label: 'Name',
            value: comment.name,
          ),
          const SizedBox(height: 2,),
          CommentAuthorBlocView(
            label: 'Email',
            value: comment.email,
          ),
          const SizedBox(height: 2,),
          CommentAuthorBlocView(
            label: 'Text',
            value: comment.body,
          ),
          const SizedBox(height: 4,),
        ],
      ),
    );
  }
}
