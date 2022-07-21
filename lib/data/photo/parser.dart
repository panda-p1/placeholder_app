import 'package:placeholder_app/data/photo/photo.dart';

class PhotoParser {
  const PhotoParser._();

  static Photo parse(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      photoUrl: json['url'],
      miniPhotoUrl: json['thumbnailUrl'],
    );
  }
}