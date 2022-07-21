import 'package:placeholder_app/api/albums_provider/requests/get_albums.dart';
import 'package:placeholder_app/api/base/base_provider.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/api/photo_provider/requests/get_photos.dart';
import 'package:placeholder_app/api/posts_provider/requests/get_posts.dart';
import 'package:placeholder_app/api/users_provider/requests/get_users.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/data/album/parser.dart';
import 'package:placeholder_app/data/photo/parser.dart';
import 'package:placeholder_app/data/photo/photo.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_bloc.dart';

class GetPhotosNetManager extends CacheableNetManager {
  final List<Album> albums;
  const GetPhotosNetManager(this.albums);

  Future<ProviderResponse<List<Photo>>> getPhotos() async {
    final request = GetPhotosRequest(albums.map((album) => album.id).toList());
    final response = await fetch(request);
    if(response.isFail()) {
      return response.unType();
    }

    final photos = (response.content as List).map((json) => PhotoParser.parse(Map<String, dynamic>.from(json)));

    return response.assignContent(photos.toList());
  }

}