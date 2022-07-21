import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/api/comments_provider/managers/send_comment.dart';
import 'package:placeholder_app/data/comment/comment.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_event.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_state.dart';
import 'package:placeholder_app/screens/send_message_screen/bloc/send_message_screen_event.dart';
import 'package:placeholder_app/screens/send_message_screen/bloc/send_message_screen_state.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_event.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_state.dart';

abstract class SendCommentRepo {
  Future<ProviderResponse> sendComment(SendCommentDetails details);
}

class SendMessageScreenBloc extends Bloc<SendMessageScreenEvent, SendMessageScreenState> {
  final SendCommentRepo sendCommentRepo;

  SendMessageScreenBloc({
    required this.sendCommentRepo,
  }) : super(const SendMessageScreenState()) {
    on<SendMessageScreenSendComment>(_trySendMessage);
  }

  void _trySendMessage(SendMessageScreenSendComment event, Emitter<SendMessageScreenState> emit) async {
    try {
      await _sendMessage(event, emit);
    } catch(e) {
      if(e is Error) {
        print(e.stackTrace);
        print(e.toString());
      }
      emit(const SendMessageScreenErrorState());
    }
  }

  Future<void> _sendMessage(SendMessageScreenSendComment event, Emitter<SendMessageScreenState> emit) async {
    emit(const SendMessageScreenLoadingState());
    final response = await sendCommentRepo.sendComment(event.details);

    if(response.isSuccess()) {
      emit(const SendMessageScreenCommentSent());
    } else {
      emit(const SendMessageScreenErrorState());
    }
  }

}
