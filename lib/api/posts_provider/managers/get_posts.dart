import 'package:placeholder_app/api/base/base_provider.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/api/posts_provider/requests/get_posts.dart';
import 'package:placeholder_app/data/post/parser.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_bloc.dart';

class GetPostsNetManager extends CacheableNetManager implements GetItemsRepo<Post> {
  GetPostsNetManager(this.user);
  final User user;


  Future<ProviderResponse<List<Post>>> getPosts() async {
    final request = GetPostsRequest(user.id);
    final response = await fetch(request);
    if(response.isFail()) {
      return response.unType();
    }
    final users = (response.content as List).map((json) => PostParser.parse(Map<String, dynamic>.from(json)));

    return response.assignContent(users.toList());
  }

  @override
  Future<ProviderResponse<List<Post>>> getItems() => getPosts();
}