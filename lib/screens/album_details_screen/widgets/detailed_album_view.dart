import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_app/data/album/album.dart';

import 'package:placeholder_app/data/photo/photo.dart';
import 'package:placeholder_app/managers/album_photos_manager.dart';
import 'package:placeholder_app/screens/album_details_screen/widgets/photo_view.dart';

class DetailedAlbumView extends StatefulWidget {
  final Album album;
  final AlbumPhotosManager albumManager;
  const DetailedAlbumView(this.album,  {Key? key,
    required this.albumManager,
  }) : super(key: key);

  @override
  State<DetailedAlbumView> createState() => _DetailedAlbumViewState();
}

class _DetailedAlbumViewState extends State<DetailedAlbumView> {

  final photos = ValueNotifier<List<Photo>?>(null);

  @override
  void initState() {
    _addPhotoListener();
    super.initState();
  }

  void _addPhotoListener() async {
    await Future.delayed(Duration.zero);
    widget.albumManager.addLoadListener(widget.album, _onPhotosLoaded, notifyIfAlreadyLoaded: true,);
  }

  void _onPhotosLoaded(List<Photo> photos) {
    this.photos.value = photos;
  }

  @override
  void dispose() {
    widget.albumManager.removeListener(_onPhotosLoaded);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8,),
        Expanded(
          child: ValueListenableBuilder<List<Photo>?>(
            valueListenable: photos,
            builder: (_, photos, __) {
              if(photos == null) {
                return const SizedBox();
              }

              return LayoutBuilder(
                builder: (context, constraints) => CarouselSlider(
                  items: [
                    ...photos.map((photo) => PhotoView(photo, )).toList()
                  ],
                  options: CarouselOptions(
                    height: constraints.maxHeight,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}