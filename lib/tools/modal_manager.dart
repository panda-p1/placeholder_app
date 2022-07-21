import 'package:flutter/cupertino.dart';

class ModalManager {
  const ModalManager._();

  static showErrorModal(BuildContext context, {
    String? title,
    String? text,
  }) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: true,
      builder: (_) =>  CupertinoAlertDialog(
        title: title == null ? null : Text(title),
        content: Text(text ?? 'Error. Please try again later'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),    );
  }
}