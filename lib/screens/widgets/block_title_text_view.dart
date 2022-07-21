import 'package:flutter/material.dart';

class BlockTitleTextView extends StatelessWidget {
  final String text;
  const BlockTitleTextView(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
