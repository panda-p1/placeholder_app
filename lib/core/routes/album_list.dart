import 'package:flutter/material.dart';
import 'package:placeholder_app/core/routes/routes.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/managers/album_photos_manager.dart';
import 'package:placeholder_app/screens/album_list_screen/album_list_screen_view.dart';

class AlbumListRoute extends AppRoute {
  const AlbumListRoute();

  @override
  WidgetBuilder get builder => (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final albums = arguments['albums'] as List<Album>;
    final manager = arguments['photoManager'] as AlbumPhotosManager;
    manager.addAlbums(albums);
    manager.loadPhotos();
    return AlbumListScreenView(albums, manager: manager,);
  };

  @override
  String get name => "album_list";
}