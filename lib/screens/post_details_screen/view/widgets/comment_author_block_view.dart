import 'package:flutter/material.dart';

class CommentAuthorBlocView extends StatelessWidget {
  final String label;
  final String value;
  const CommentAuthorBlocView({Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaleFactor: MediaQuery.textScaleFactorOf(context),
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      )
    );
  }
}
