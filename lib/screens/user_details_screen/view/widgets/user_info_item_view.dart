import 'package:flutter/material.dart';
import 'package:placeholder_app/screens/widgets/block_title_text_view.dart';

class UserInfoItemView extends StatelessWidget {
  final String label;
  final String value;
  const UserInfoItemView({Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlockTitleTextView(label),
        const SizedBox(height: 2,),
        Text(value),
      ],
    );
  }
}
