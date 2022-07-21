import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/data/photo/photo.dart';
import 'package:placeholder_app/managers/album_photos_manager.dart';
import 'package:placeholder_app/screens/album_details_screen/widgets/detailed_album_view.dart';

class AlbumDetailsScreenView extends StatefulWidget {
  final Album album;
  final AlbumPhotosManager manager;
  const AlbumDetailsScreenView(this.album, {Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<AlbumDetailsScreenView> createState() => _AlbumDetailsScreenViewState();
}

class _AlbumDetailsScreenViewState extends State<AlbumDetailsScreenView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.title),
      ),
      body: DetailedAlbumView(widget.album, albumManager: widget.manager,),
    );
  }
}
