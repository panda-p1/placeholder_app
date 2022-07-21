import 'package:flutter/material.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/screens/post_details_screen/view/widgets/comments_view.dart';
import 'package:placeholder_app/screens/post_details_screen/view/widgets/send_view.dart';

class PostDetailsScreenView extends StatefulWidget {
  final Post post;
  const PostDetailsScreenView(this.post, {Key? key}) : super(key: key);

  @override
  State<PostDetailsScreenView> createState() => _PostDetailsScreenViewState();
}

class _PostDetailsScreenViewState extends State<PostDetailsScreenView> {

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(widget.post.body),
                    ),
                    const Divider(),
                    const PostDetailsScreenCommentsView(),
                  ],
                ),
              ),
            ),
          ),
          PostDetailsScreenSendView(
            onSend: onMessageSend,
          ),
        ],
      ),
    );
  }

  void onMessageSend() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn,);
  }
}
