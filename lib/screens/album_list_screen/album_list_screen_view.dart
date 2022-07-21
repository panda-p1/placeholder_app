import 'package:flutter/material.dart';
import 'package:placeholder_app/core/routes/album_details.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/managers/album_photos_manager.dart';
import 'package:placeholder_app/screens/widgets/album_table_view.dart';
import 'package:placeholder_app/screens/widgets/shorted_album_view.dart';

class AlbumListScreenView extends StatelessWidget {
  final List<Album> albums;
  final AlbumPhotosManager manager;
  const AlbumListScreenView(this.albums, {Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: SingleChildScrollView(
        child: AlbumTableView(
          albums,
          itemBuilder: (album) => ShortedAlbumView(album,
            albumManager: manager,
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            onPressed: () => onAlbumPressed(context, album),
          ),
        ),
      ),
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
}
