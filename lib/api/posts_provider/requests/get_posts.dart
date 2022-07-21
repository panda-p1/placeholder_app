import 'package:placeholder_app/api/base/base_provider.dart';

class GetPostsRequest extends HttpRequest {
  final int userId;

  const GetPostsRequest(this.userId);

  @override
  String get url => "https://jsonplaceholder.typicode.com/posts";

  @override
  bool get isCacheable => true;

  @override
  Map<String, dynamic>? get body => {
    "userId": userId,
  };

  @override
  Duration get cacheDuration => const Duration(minutes: 2);
}