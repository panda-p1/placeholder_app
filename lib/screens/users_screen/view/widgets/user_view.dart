import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/posts_provider/managers/get_posts.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_bloc.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_event.dart';
import 'package:placeholder_app/screens/user_details_screen/view/user_details_screen.dart';

class UserView extends StatelessWidget {
  final User user;
  final EdgeInsets? margin;
  final void Function() onPressed;
  const UserView(this.user, {Key? key,
    this.margin,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,),
                const SizedBox(height: 4,),
                Text(user.username, 
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: double.infinity,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
