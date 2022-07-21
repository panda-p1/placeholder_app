import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/comments_provider/managers/send_comment.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_bloc.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_event.dart';
import 'package:placeholder_app/screens/send_message_screen/bloc/send_message_screen_bloc.dart';
import 'package:placeholder_app/screens/send_message_screen/bloc/send_message_screen_event.dart';
import 'package:placeholder_app/screens/send_message_screen/bloc/send_message_screen_state.dart';
import 'package:placeholder_app/screens/widgets/block_title_text_view.dart';
import 'package:placeholder_app/tools/loading_overlay/loading_overlay.dart';
import 'package:placeholder_app/tools/modal_manager.dart';

class SendMessageScreenView extends StatefulWidget {
  final String text;
  const SendMessageScreenView(this.text, {Key? key}) : super(key: key);

  @override
  State<SendMessageScreenView> createState() => _SendMessageScreenViewState();
}

class _SendMessageScreenViewState extends State<SendMessageScreenView> {

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final isSubmitButtonActive = ValueNotifier(false);

  @override
  void initState() {
    nameTextController.addListener(textListener);
    emailTextController.addListener(textListener);
    super.initState();
  }

  void textListener() {
    isSubmitButtonActive.value = nameTextController.text.isNotEmpty && emailTextController.text.isNotEmpty;
  }

  @override
  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocListener<SendMessageScreenBloc, SendMessageScreenState> (
                  listener: (context, state) {
                    if(state is SendMessageScreenLoadingState) {
                      LoadingOverlay.show(context);
                    } else {
                      LoadingOverlay.hide();
                    }
                    if(state is SendMessageScreenErrorState) {
                      ModalManager.showErrorModal(context, text: state.message, title: state.title,);
                    }
                    if(state is SendMessageScreenCommentSent) {
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const SizedBox(),
                ),
                const BlockTitleTextView("Enter your contacts"),
                const SizedBox(height: 8,),
                TextField(
                  controller: nameTextController,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    isDense: true,
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16,),
                TextField(
                  controller: emailTextController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    isDense: true,
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16,),

                Align(
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isSubmitButtonActive,
                    builder: (context, active, _) => TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.blue),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: active ? onSubmitPressed : null,
                      icon: const Icon(Icons.send_rounded,),
                      label: const Text('Submit'),
                      // label: const SizedBox(),
                    ),
                  )
                ),
                const BlockTitleTextView("Your message"),
                const SizedBox(height: 8,),

                Text(widget.text,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmitPressed() {
    FocusScope.of(context).unfocus();
    BlocProvider.of<SendMessageScreenBloc>(context).add(SendMessageScreenSendComment(
      SendCommentDetails(
        name: nameTextController.text,
        email: emailTextController.text,
        text: widget.text,
      ),
    ));
  }
}
