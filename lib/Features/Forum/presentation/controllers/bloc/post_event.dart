// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostEvent {}

class UploadPostEvent extends PostEvent {
  final String title;
  final String content;
  final User user;
  UploadPostEvent({
    required this.title,
    required this.content,
    required this.user,
  });
}

class LikePostsEvent extends PostEvent {
  final Post post;
  final String uid;
  const LikePostsEvent(this.post, this.uid);
  @override
  List<Object> get props => [post, uid];
}
