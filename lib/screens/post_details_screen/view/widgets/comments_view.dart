import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/tools/modal_manager.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_bloc.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_state.dart';
import 'package:placeholder_app/screens/post_details_screen/view/widgets/comment_view.dart';
import 'package:placeholder_app/screens/post_details_screen/view/widgets/text_field_view.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_bloc.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_event.dart';
import 'package:placeholder_app/screens/widgets/block_title_text_view.dart';
class PostDetailsScreenCommentsView extends StatelessWidget {
  const PostDetailsScreenCommentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostDetailsScreenBloc, PostDetailsScreenState> (
      listener: (context, state) {
        if(state is PostDetailsScreenErrorState) {
          ModalManager.showErrorModal(context, title: state.title, text: state.errorMessage,);
        }
      },
      builder: (context, state) {
        if(state is PostDetailsScreenInitialState) {
          return const SizedBox();
        }

        if(state is PostDetailsScreenLoadingState) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if(state is PostDetailsScreenErrorState) {
          return Center(
            child: TextButton(
              onPressed: () => onReloadPressed(context),
              child: const Text('Reload'),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: BlockTitleTextView('Comments'),
            ),

            ...state.comments.map((comment) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
              child: CommentView(comment,
                // margin: const EdgeInsets.symmetric(
                //   horizontal: 16,
                //   vertical: 4,
                // ),
              ),
            )).toList(),
          ],
        );

      },
    );
  }

  void onReloadPressed(BuildContext context) {
    context.read<UsersScreenBloc>().add(UsersScreenLoad());
  }
}
