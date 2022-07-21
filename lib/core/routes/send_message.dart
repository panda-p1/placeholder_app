import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/comments_provider/managers/send_comment.dart';
import 'package:placeholder_app/core/routes/routes.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_bloc.dart';
import 'package:placeholder_app/screens/send_message_screen/bloc/send_message_screen_bloc.dart';
import 'package:placeholder_app/screens/send_message_screen/view/send_message_screen_view.dart';

class SendMessageRoute extends AppRoute {
  const SendMessageRoute();

  @override
  WidgetBuilder get builder => (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final text = arguments['text'] as String;
    final bloc = arguments['bloc'] as PostDetailsScreenBloc;

    return BlocProvider(
      create: (context) => SendMessageScreenBloc(
        sendCommentRepo: SendCommentNetManager(addComment: bloc,),
      ),
      child: SendMessageScreenView(text),
    );
  };

  @override
  String get name => "send_message";
}