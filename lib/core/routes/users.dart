import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/users_provider/managers/get_users.dart';
import 'package:placeholder_app/core/routes/routes.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_bloc.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_event.dart';
import 'package:placeholder_app/screens/users_screen/view/users_screen.dart';

class UsersRoute extends AppRoute {
  const UsersRoute();

  @override
  WidgetBuilder get builder => (context) => BlocProvider(
    create: (BuildContext context) => UsersScreenBloc(
      getUsersRepo: GetUsersNetManager(),
    )..add(UsersScreenLoad()),
    child: const UsersScreenView(),
  );

  @override
  String get name => "/";
}