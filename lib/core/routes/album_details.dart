import 'package:flutter/material.dart';
import 'package:placeholder_app/core/routes/routes.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/managers/album_photos_manager.dart';
import 'package:placeholder_app/screens/album_details_screen/album_details_screen_view.dart';
import 'package:placeholder_app/screens/album_list_screen/album_list_screen_view.dart';

class AlbumDetailsRoute extends AppRoute {
  const AlbumDetailsRoute();

  @override
  WidgetBuilder get builder => (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final album = arguments['album'] as Album;
    final manager = arguments['photoManager'] as AlbumPhotosManager;
    manager.addAlbums([album]);
    manager.loadPhotos();
    return AlbumDetailsScreenView(album, manager: manager,);
  };

  @override
  String get name => "album_details";
}