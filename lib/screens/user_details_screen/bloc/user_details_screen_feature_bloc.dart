import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_event.dart';
import 'package:placeholder_app/screens/user_details_screen/bloc/user_details_screen_feature_state.dart';

abstract class GetItemsRepo<T> {
  Future<ProviderResponse<List<T>>> getItems();
}

class UserDetailsScreenFeatureBloc<T> extends Bloc<UserDetailsScreenFeatureEvent, UserDetailsScreenFeatureState<T>> {
  final GetItemsRepo<T> getItemsRepo;

  UserDetailsScreenFeatureBloc({
    required this.getItemsRepo,
  }) : super(UserDetailsScreenFeatureInitialState()) {
    on<UserDetailsScreenFeatureLoad>(_tryLoad);
  }

  void _tryLoad(UserDetailsScreenFeatureEvent event, Emitter<UserDetailsScreenFeatureState<T>> emit) async {
    try {
      await _load(emit);
    } catch(e) {
      if(e is Error) {
        print(e.stackTrace);
        print(e.toString());
      }
      emit(UserDetailsScreenFeatureErrorState<T>());
    }
  }

  Future<void> _load(Emitter<UserDetailsScreenFeatureState> emit) async {
    emit(UserDetailsScreenFeatureLoadingState<T>());
    final response = await getItemsRepo.getItems();

    if(response.isSuccess()) {
      emit(UserDetailsScreenFeatureLoadedState<T>(response.content!,));
    } else {
      emit(UserDetailsScreenFeatureErrorState<T>());
    }
  }
}
