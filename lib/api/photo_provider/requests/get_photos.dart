import 'package:placeholder_app/api/base/base_provider.dart';

class GetPhotosRequest extends HttpRequest {
  final List<int> albumIds;

  const GetPhotosRequest(this.albumIds);

  @override
  String get url => "https://jsonplaceholder.typicode.com/photos";

  @override
  bool get isCacheable => true;

  @override
  Map<String, dynamic>? get parameters => {
    "albumId": albumIds.map((e) => e.toString()).toList(),
  };

  @override
  Duration get cacheDuration => const Duration(minutes: 2);
}