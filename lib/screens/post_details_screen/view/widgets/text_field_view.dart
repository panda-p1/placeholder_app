import 'package:flutter/material.dart';

class MakeCommentTextFieldView extends StatelessWidget {
  final TextEditingController? controller;
  const MakeCommentTextFieldView({Key? key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Write your comment here',
        ),
      ),
    );
  }
}
