import 'package:placeholder_app/api/albums_provider/requests/get_albums.dart';
import 'package:placeholder_app/api/base/base_provider.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/api/posts_provider/requests/get_posts.dart';
import 'package:placeholder_app/api/users_provider/requests/get_users.dart';
import 'package:placeholder_app/data/album/album.dart';
import 'package:placeholder_app/data/album/parser.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_bloc.dart';

class GetAlbumsNetManager extends CacheableNetManager implements GetItemsRepo<Album> {
  GetAlbumsNetManager(this.user);
  final User user;

  Future<ProviderResponse<List<Album>>> getAlbums() async {
    final request = GetAlbumsRequest(user.id);
    final response = await fetch(request);
    if(response.isFail()) {
      return response.unType();
    }

    final users = (response.content as List).map((json) => AlbumParser.parse(Map<String, dynamic>.from(json)));

    return response.assignContent(users.toList());
  }

  @override
  Future<ProviderResponse<List<Album>>> getItems() => getAlbums();
}