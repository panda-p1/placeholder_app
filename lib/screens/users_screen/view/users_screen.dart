import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/albums_provider/managers/get_albums.dart';
import 'package:placeholder_app/api/posts_provider/managers/get_posts.dart';
import 'package:placeholder_app/core/routes/user_details.dart';
import 'package:placeholder_app/tools/modal_manager.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_bloc.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_event.dart';
import 'package:placeholder_app/screens/user_details_screen/view/user_details_screen.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_bloc.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_event.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_state.dart';
import 'package:placeholder_app/screens/users_screen/view/widgets/user_view.dart';
import 'package:placeholder_app/screens/widgets/block_title_text_view.dart';

class UsersScreenView extends StatelessWidget {
  const UsersScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UsersScreenBloc, UsersScreenState> (
          listener: (context, state) {
            if(state is UsersScreenErrorState) {
              ModalManager.showErrorModal(context, title: state.title, text: state.errorMessage,);
            }
          },
          builder: (context, state) {

            if(state is UsersScreenInitialState) {
              return const SizedBox();
            }

            if(state is UsersScreenLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if(state is UsersScreenErrorState) {
              return Center(
                child: TextButton(
                  onPressed: () => onReloadPressed(context),
                  child: const Text('Reload'),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: BlockTitleTextView('Users',),
                  ),
                  const SizedBox(height: 16,),
                  ...state.users.map((user) => UserView(user,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    onPressed: () => onUserPressed(context, user),
                  )).toList(),
                ],
              ),
            );

          },
        ),
      ),
    );
  }

  void onUserPressed(BuildContext context, User user) {
    Navigator.pushNamed(context, const UserDetailsRoute().name, arguments: user);
  }

  void onReloadPressed(BuildContext context) {
    context.read<UsersScreenBloc>().add(UsersScreenLoad());
  }
}
