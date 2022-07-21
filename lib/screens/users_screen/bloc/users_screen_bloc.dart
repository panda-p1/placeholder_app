import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_event.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_state.dart';

abstract class GetUsersRepo {
  Future<ProviderResponse<List<User>>> getUsers();
}

class UsersScreenBloc extends Bloc<UsersScreenEvent, UsersScreenState> {
  final GetUsersRepo getUsersRepo;

  UsersScreenBloc({
    required this.getUsersRepo,
  }) : super(const UsersScreenInitialState()) {
    on<UsersScreenLoad>(_tryLoad);
  }

  void _tryLoad(UsersScreenLoad event, Emitter<UsersScreenState> emit) async {
    try {
      await _load(emit);
    } catch(e) {
      if(e is Error) {
        print(e.stackTrace);
        print(e.toString());
      }
      emit(const UsersScreenErrorState());
    }
  }

  Future<void> _load(Emitter<UsersScreenState> emit) async {
    emit(const UsersScreenLoadingState());
    final response = await getUsersRepo.getUsers();

    if(response.isSuccess()) {
      emit(UsersScreenLoadedState(response.content!));
    } else {
      emit(const UsersScreenErrorState());
    }
  }
}
