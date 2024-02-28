// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class LoadingPostsState extends PostState {}

class EmptyPostsState extends PostState {
  final String message;
  const EmptyPostsState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadedPostsSState extends PostState {
  final List<Post> posts;
  const LoadedPostsSState({
    required this.posts,
  });
  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostState {
  final String message;
  const ErrorPostsState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
