import 'package:placeholder_app/api/comments_provider/managers/send_comment.dart';

abstract class SendMessageScreenEvent {
  const SendMessageScreenEvent();
}

class SendMessageScreenSendComment extends SendMessageScreenEvent {
  final SendCommentDetails details;
  const SendMessageScreenSendComment(this.details, );
}
