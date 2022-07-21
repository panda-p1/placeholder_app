import 'package:placeholder_app/api/base/base_provider.dart';

class GetUsersRequest extends HttpRequest {
  @override
  String get url => "https://jsonplaceholder.typicode.com/users";

  @override
  bool get isCacheable => true;

  @override
  Duration get cacheDuration => const Duration(minutes: 2);
}