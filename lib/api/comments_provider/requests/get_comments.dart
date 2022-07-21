import 'package:placeholder_app/api/base/base_provider.dart';

class GetCommentsRequest extends HttpRequest {
  final int postId;

  const GetCommentsRequest(this.postId);

  @override
  String get url => "https://jsonplaceholder.typicode.com/comments";

  @override
  bool get isCacheable => true;

  @override
  Map<String, dynamic>? get body => {
    "postId": postId,
  };

  @override
  Duration get cacheDuration => const Duration(minutes: 2);
}