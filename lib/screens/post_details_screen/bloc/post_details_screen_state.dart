import 'package:equatable/equatable.dart';
import 'package:placeholder_app/data/comment/comment.dart';

class PostDetailsScreenState extends Equatable {
  final List<Comment> comments;

  const PostDetailsScreenState(this.comments, );

  PostDetailsScreenState copyWith({List<Comment>? comments} ) => PostDetailsScreenState(
    comments ?? this.comments,
  );

  @override
  List<Object?> get props => [comments];
}

class PostDetailsScreenInitialState extends PostDetailsScreenState {
  const PostDetailsScreenInitialState(): super(const []);
}

class PostDetailsScreenLoadingState extends PostDetailsScreenState {
  const PostDetailsScreenLoadingState(): super(const []);
}

class PostDetailsScreenErrorState extends PostDetailsScreenState {
  final String? title;
  final String? errorMessage;
  const PostDetailsScreenErrorState({this.title, this.errorMessage,}): super(const []);
}

class PostDetailsScreenLoadedState  extends PostDetailsScreenState {
  const PostDetailsScreenLoadedState(super.comments);
}

