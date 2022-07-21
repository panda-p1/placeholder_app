import 'package:placeholder_app/api/base/base_provider.dart';
import 'package:placeholder_app/api/comments_provider/managers/send_comment.dart';
import 'package:placeholder_app/enums/http_method.dart';

class SendCommentRequest extends HttpRequest {
  final int postId;
  final SendCommentDetails sendCommentDetails;
  const SendCommentRequest(this.postId, {required this.sendCommentDetails, });

  @override
  String get url => "https://jsonplaceholder.typicode.com/comments";

  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  bool get isCacheable => false;

  @override
  Map<String, dynamic>? get body => {
    "postId": postId.toString(),
    "body": sendCommentDetails.text,
    "name": sendCommentDetails.name,
    "email": sendCommentDetails.email,
  };
}