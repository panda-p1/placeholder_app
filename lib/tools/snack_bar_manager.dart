import 'package:flutter/material.dart';

class SnackbarManager {
  const SnackbarManager._();

  static void showErrorSnackbar(BuildContext context,{
    String? title,
    String? text,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(title != null)
              Text(title),
            Text(text ?? 'Error. Please try again later'),
          ],
        ),
      ),
    );
  }
}