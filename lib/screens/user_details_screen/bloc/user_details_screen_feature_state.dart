import 'package:equatable/equatable.dart';
import 'package:placeholder_app/data/user/user.dart';

class UserDetailsScreenFeatureState<T> extends Equatable {
  final List<T> items;
  const UserDetailsScreenFeatureState(this.items, );

  @override
  List<Object?> get props => [items];
}

class UserDetailsScreenFeatureInitialState<T> extends UserDetailsScreenFeatureState<T> {
  const UserDetailsScreenFeatureInitialState(): super(const [], );
}

class UserDetailsScreenFeatureLoadingState<T> extends UserDetailsScreenFeatureState<T> {
  const UserDetailsScreenFeatureLoadingState(): super(const [],);
}

class UserDetailsScreenFeatureErrorState<T> extends UserDetailsScreenFeatureState<T> {
  final String? title;
  final String? errorMessage;
  const UserDetailsScreenFeatureErrorState({this.title, this.errorMessage,}): super(const [],);
}

class UserDetailsScreenFeatureLoadedState<T> extends UserDetailsScreenFeatureState<T> {
  const UserDetailsScreenFeatureLoadedState(List<T> items,): super(items, );
}

