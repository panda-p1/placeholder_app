import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:placeholder_app/core/routes/album_details.dart';
import 'package:placeholder_app/core/routes/album_list.dart';
import 'package:placeholder_app/core/routes/post_details.dart';
import 'package:placeholder_app/core/routes/post_list.dart';
import 'package:placeholder_app/core/routes/send_message.dart';
import 'package:placeholder_app/core/routes/user_details.dart';
import 'package:placeholder_app/core/routes/users.dart';

abstract class AppRoute {
  String get name;
  WidgetBuilder get builder;
  const AppRoute();
}

class AppRoutes with ListMixin<AppRoute> {
  final List<AppRoute> routes = [
    const UsersRoute(),
    const UserDetailsRoute(),
    const PostListRoute(),
    const PostDetailsRoute(),
    const SendMessageRoute(),
    const AlbumListRoute(),
    const AlbumDetailsRoute(),
  ];

  AppRoutes();

  Map<String, WidgetBuilder> represent() => asMap()
      .map((key, route) => MapEntry(route.name, route.builder));

  @override
  int get length => routes.length;

  @override
  set length(int newLength) => routes.length = newLength;

  @override
  operator [](int index) => routes[index];

  @override
  void operator []=(int index, AppRoute value) => routes[index] = value;
}