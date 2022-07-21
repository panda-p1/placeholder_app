import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/api/comments_provider/managers/send_comment.dart';
import 'package:placeholder_app/data/comment/comment.dart';
import 'package:placeholder_app/data/post/post.dart';
import 'package:placeholder_app/data/user/user.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_event.dart';
import 'package:placeholder_app/screens/post_details_screen/bloc/post_details_screen_state.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_event.dart';
import 'package:placeholder_app/screens/users_screen/bloc/users_screen_state.dart';

abstract class GetCommentsRepo {
  Future<ProviderResponse<List<Comment>>> getComments();
}

class PostDetailsScreenBloc extends Bloc<PostDetailsScreenEvent, PostDetailsScreenState> implements AddComment {
  final GetCommentsRepo getCommentsRepo;
  @override
  final Post post;
  PostDetailsScreenBloc({
    required this.getCommentsRepo,
    required this.post,
  }) : super(const PostDetailsScreenInitialState()) {
    on<PostDetailsScreenLoad>(_tryLoad);
    on<PostDetailsScreenAddComment>(_addComment);
  }

  @override
  void addComment(Comment comment) {
    add(PostDetailsScreenAddComment(comment));
  }

  void _addComment(PostDetailsScreenAddComment event, Emitter<PostDetailsScreenState> emit) {
    emit(state.copyWith(comments: [event.comment, ...state.comments]));
  }

  void _tryLoad(PostDetailsScreenLoad event, Emitter<PostDetailsScreenState> emit) async {
    try {
      await _load(emit);
    } catch(e) {
      if(e is Error) {
        print(e.stackTrace);
        print(e.toString());
      }
      emit(const PostDetailsScreenErrorState());
    }
  }

  Future<void> _load(Emitter<PostDetailsScreenState> emit) async {
    emit(const PostDetailsScreenLoadingState());
    final response = await getCommentsRepo.getComments();

    if(response.isSuccess()) {
      emit(PostDetailsScreenLoadedState(response.content!));
    } else {
      emit(const PostDetailsScreenErrorState());
    }
  }
}
