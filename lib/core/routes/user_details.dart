import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/albums_provider/managers/get_albums.dart';
import 'package:placeholder_app/api/posts_provider/managers/get_posts.dart';
import 'package:placeholder_app/core/routes/routes.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_bloc.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_event.dart';
import 'package:placeholder_app/screens/user_details_screen/view/user_details_screen.dart';

class UserDetailsRoute extends AppRoute {
  const UserDetailsRoute();

  @override
  WidgetBuilder get builder => (context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserDetailsScreenFeatureBloc<Post>(
            getItemsRepo: GetPostsNetManager(user),
          )..add(UserDetailsScreenFeatureLoad()),
        ),
        BlocProvider(
          create: (context) => UserDetailsScreenFeatureBloc<Album>(
            getItemsRepo: GetAlbumsNetManager(user),
          )..add(UserDetailsScreenFeatureLoad()),
        ),
      ],
      child: UserDetailsScreenView(user),
    );
  };

  @override
  String get name => "user_details";
}