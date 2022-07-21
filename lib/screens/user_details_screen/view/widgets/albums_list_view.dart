import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/core/routes/album_details.dart';
import 'package:placeholder_app/core/routes/album_list.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/managers/album_photos_manager.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_bloc.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_event.dart';
import 'package:placeholder_app/screens/user_details_screen/view/widgets/bloc_view.dart';
import 'package:placeholder_app/screens/widgets/album_table_view.dart';
import 'package:placeholder_app/screens/widgets/block_title_text_view.dart';
import 'package:placeholder_app/screens/widgets/shorted_album_view.dart';

class UserDetailsScreenAlbumListView extends StatefulWidget {
  const UserDetailsScreenAlbumListView({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreenAlbumListView> createState() => _UserDetailsScreenAlbumListViewState();
}

class _UserDetailsScreenAlbumListViewState extends State<UserDetailsScreenAlbumListView> {
  AlbumPhotosManager? manager;
  static const itemsQuantity = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: BlockTitleTextView('Albums',),
        ),

        UserDetailsScreenFeatureBlocView<Album>(
          onLoadedState: (albums) => manager = AlbumPhotosManager(albums.sublist(0, min(albums.length, itemsQuantity))
          )..loadPhotos(),
          onSeeMorePressed: (posts) => onAlbumSeeMoreView(context, posts),
          itemsQuantity: itemsQuantity,
          itemsBuilder: (_, albums) => AlbumTableView(
            albums,
            itemBuilder: (album) => ShortedAlbumView(album,
              albumManager: manager!,
              margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              onPressed: () => onAlbumPressed(context, album),
            ),
          ),
        ),
      ],
    );
  }

  void onAlbumPressed(BuildContext context, Album album) {
    Navigator.of(context).pushNamed(const AlbumDetailsRoute().name,
      arguments: {
        "album": album,
        "photoManager": manager,
      },
    );
  }

  void onAlbumSeeMoreView(BuildContext context, List<Album> albums) {
    manager?.addAlbums(albums);
    Navigator.pushNamed(context,
      const AlbumListRoute().name,
      arguments: {
        "albums": albums,
        "photoManager": manager,
      },
    );
  }

  void onReloadPressed(BuildContext context) {
    context.read<UserDetailsScreenFeatureBloc<Album>>().add(UserDetailsScreenFeatureLoad());
  }
}
