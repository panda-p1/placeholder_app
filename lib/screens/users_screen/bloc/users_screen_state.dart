import 'package:equatable/equatable.dart';
import 'package:placeholder_app/data/user/user.dart';

class UsersScreenState extends Equatable {
  final List<User> users;

  const UsersScreenState(this.users);

  @override
  List<Object?> get props => [users];
}

class UsersScreenInitialState extends UsersScreenState {
  const UsersScreenInitialState(): super(const []);
}

class UsersScreenLoadingState extends UsersScreenState {
  const UsersScreenLoadingState(): super(const []);
}

class UsersScreenErrorState extends UsersScreenState {
  final String? title;
  final String? errorMessage;
  const UsersScreenErrorState({this.title, this.errorMessage,}): super(const []);
}

class UsersScreenLoadedState  extends UsersScreenState {
  const UsersScreenLoadedState(List<User> users): super(users);
}

