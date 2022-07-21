import 'dart:math';

import 'package:flutter/material.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/data/photo/photo.dart';
import 'package:placeholder_app/managers/album_photos_manager.dart';

class ShortedAlbumView extends StatefulWidget {
  final Album album;
  final EdgeInsets? margin;
  final void Function() onPressed;
  final AlbumPhotosManager albumManager;
  const ShortedAlbumView(this.album,  {Key? key,
    this.margin,
    required this.onPressed,
    required this.albumManager,
  }) : super(key: key);

  @override
  State<ShortedAlbumView> createState() => _ShortedAlbumViewState();
}

class _ShortedAlbumViewState extends State<ShortedAlbumView> {

  List<Photo>? photos;
  final thumbnail = ValueNotifier<Photo?>(null);

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
    this.photos = photos;
    if(photos.isNotEmpty) {
      thumbnail.value = photos.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          color: Colors.white,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0,),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      const SizedBox(height: 8,),
                      ValueListenableBuilder<Photo?>(
                        valueListenable: thumbnail,
                        builder: (_, photo, __) {
                          final size = min(constraints.maxWidth, constraints.maxHeight);
                          if(photo == null) {
                            return SizedBox(
                              height: size,
                              width: size,
                            );
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(size / 2), // Image radius
                              child: Image.network(photo.miniPhotoUrl, fit: BoxFit.cover),
                            ),
                          );
                          // return NetworkImage(photo.miniPhotoUrl, );
                        },
                      ),
                      const SizedBox(height: 8,),
                      Text(widget.album.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.albumManager.removeListener(_onPhotosLoaded);
    super.dispose();
  }
}
