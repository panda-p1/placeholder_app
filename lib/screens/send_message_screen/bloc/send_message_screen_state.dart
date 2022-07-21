import 'package:equatable/equatable.dart';
import 'package:placeholder_app/data/comment/comment.dart';

class SendMessageScreenState extends Equatable {
  const SendMessageScreenState();

  @override
  List<Object?> get props => [];
}

class SendMessageScreenLoadingState extends SendMessageScreenState {
  const SendMessageScreenLoadingState();
}

class SendMessageScreenCommentSent extends SendMessageScreenState {
  const SendMessageScreenCommentSent();
}

class SendMessageScreenErrorState extends SendMessageScreenState {
  final String? title;
  final String? message;

  const SendMessageScreenErrorState({this.title, this.message});
}
