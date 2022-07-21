import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_bloc.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_event.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_state.dart';
import 'package:placeholder_app/screens/user_details_screen/view/widgets/see_more_view.dart';
import 'package:placeholder_app/tools/snack_bar_manager.dart';

class UserDetailsScreenFeatureBlocView<T> extends StatelessWidget {
  final void Function(List<T>) onSeeMorePressed;
  final Widget Function(BuildContext, List<T>) itemsBuilder;
  final void Function(List<T>)? onLoadedState;
  final int itemsQuantity;
  const UserDetailsScreenFeatureBlocView({Key? key,
    required this.onSeeMorePressed,
    required this.itemsBuilder,
    required this.itemsQuantity,
    this.onLoadedState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDetailsScreenFeatureBloc<T>, UserDetailsScreenFeatureState<T>> (
      listener: (context, state) {
        if(state is UserDetailsScreenFeatureLoadedState<T>) {
          onLoadedState?.call(state.items);
        }
        if(state is UserDetailsScreenFeatureErrorState<T>) {
          SnackbarManager.showErrorSnackbar(context,
            title: state.title,
            text: state.errorMessage,
          );
        }
      },
      builder: (context, state) {

        if(state is UserDetailsScreenFeatureInitialState) {
          return const SizedBox();
        }

        if(state is UserDetailsScreenFeatureLoadingState) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if(state is UserDetailsScreenFeatureErrorState) {
          return Center(
            child: TextButton(
              onPressed: () => onReloadPressed(context),
              child: const Text('Reload'),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8,),
            itemsBuilder(context, state.items.sublist(0, min(itemsQuantity, state.items.length))),

            if(state.items.length > itemsQuantity)
              ...[
                const SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SeeMoreViewButton(() => onSeeMorePressed(state.items)),
                ),
              ],
          ],
        );

      },
    );
  }

  void onReloadPressed(BuildContext context) {
    context.read<UserDetailsScreenFeatureBloc<T>>().add(UserDetailsScreenFeatureLoad());
  }
}
