import 'dart:math';

import 'package:flutter/material.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/user_details_screen/view/widgets/albums_list_view.dart';
import 'package:placeholder_app/screens/user_details_screen/view/widgets/posts_list_view.dart';
import 'package:placeholder_app/screens/user_details_screen/view/widgets/user_info_item_view.dart';

class UserDetailsScreenView extends StatelessWidget {
  final User user;
  const UserDetailsScreenView(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16,),
                  UserInfoItemView(
                    label: 'Name',
                    value: user.name,
                  ),
                  const SizedBox(height: 8,),
                  UserInfoItemView(
                    label: 'Email',
                    value: user.email,
                  ),
                  const SizedBox(height: 8,),
                  UserInfoItemView(
                    label: 'Phone',
                    value: user.phone,
                  ),
                  const SizedBox(height: 8,),
                  UserInfoItemView(
                    label: 'Website',
                    value: user.website,
                  ),

                ],
              ),
            ),

            const SizedBox(height: 16,),

            const UserDetailsScreenPostListView(),

            const SizedBox(height: 16,),

            const UserDetailsScreenAlbumListView(),
            SizedBox(
              height: max(MediaQuery.of(context).padding.bottom, 8),
            ),
          ],
        ),
      ),
    );
  }
}
