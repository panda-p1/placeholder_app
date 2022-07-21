import 'package:placeholder_app/data/album/album.dart';

class AlbumParser {
  const AlbumParser._();

  static Album parse(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }
}