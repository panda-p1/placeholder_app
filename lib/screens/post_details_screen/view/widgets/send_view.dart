import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/core/routes/send_message.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_bloc.dart';
import 'package:placeholder_app/screens/post_details_screen/view/widgets/text_field_view.dart';

class PostDetailsScreenSendView extends StatefulWidget {
  final void Function()? onSend;
  const PostDetailsScreenSendView({Key? key,
    this.onSend,
  }) : super(key: key);

  @override
  State<PostDetailsScreenSendView> createState() => _PostDetailsScreenSendViewState();
}

class _PostDetailsScreenSendViewState extends State<PostDetailsScreenSendView> {

  final textController = TextEditingController();
  final isSendMessageActive = ValueNotifier(false);

  void _textControllerListener() {
    isSendMessageActive.value = textController.text.isNotEmpty;
  }

  @override
  void initState() {
    textController.addListener(_textControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: 8,),
              Expanded(
                child: MakeCommentTextFieldView(
                  controller: textController,
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isSendMessageActive,
                builder: (_, active, __) => TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.blue),
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  onPressed: active ? onSendPressed : null,
                  child: const Icon(Icons.send_rounded,),
                  // label: const SizedBox(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: max(MediaQuery.of(context).padding.bottom, 8),
          ),
        ],
      ),
    );
  }

  void onSendPressed() async {
    FocusScope.of(context).unfocus();
    final sent = await Navigator.of(context).pushNamed(const SendMessageRoute().name,
      arguments: {
        "text": textController.text,
        "bloc": BlocProvider.of<PostDetailsScreenBloc>(context),
      },
    );

    if(sent is bool && sent) {
      _clearField();
      widget.onSend?.call();
    }
  }

  void _clearField() {
    textController.text = '';
  }

}
