import 'dart:math';

import 'package:flutter/material.dart';
import 'package:placeholder_app/data/photo/photo.dart';

class PhotoView extends StatelessWidget {
  final Photo photo;
  const PhotoView(this.photo, {Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final size = min(constraints.maxWidth, constraints.maxHeight);

          return Column(
            children: [
              SizedBox(
                width: constraints.maxWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: Image.network(photo.photoUrl, fit: BoxFit.cover,
                    width: size,
                    height: size,
                  ),
                ),
              ),
              const SizedBox(height: 4,),
              Text(photo.title),
            ],
          );
        },
      ),
    );
  }
}
