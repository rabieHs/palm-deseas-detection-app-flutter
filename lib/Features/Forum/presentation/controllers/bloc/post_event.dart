part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostEvent {}

class LikePostsEvent extends PostEvent {
  final Post post;
  final String uid;
  const LikePostsEvent(this.post, this.uid);
  @override
  List<Object> get props => [post, uid];
}
