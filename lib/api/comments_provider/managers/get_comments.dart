import 'package:placeholder_app/api/base/base_provider.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/api/comments_provider/requests/get_comments.dart';
import 'package:placeholder_app/data/comment/comment.dart';
import 'package:placeholder_app/data/comment/parser.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_bloc.dart';

class GetCommentsNetManager extends CacheableNetManager implements GetCommentsRepo {
  const GetCommentsNetManager(this.post);
  final Post post;

  @override
  Future<ProviderResponse<List<Comment>>> getComments() async {
    final request = GetCommentsRequest(post.id);
    final response = await fetch(request);

    if(response.isFail()) {
      return response.unType();
    }
    final comments = (response.content as List).map((json) => CommentParser.parse(Map<String, dynamic>.from(json)));

    return response.assignContent(comments.toList());
  }
}