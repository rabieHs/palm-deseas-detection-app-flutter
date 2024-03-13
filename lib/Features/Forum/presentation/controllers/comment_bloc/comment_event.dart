// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class StreamCommentsEvent extends CommentEvent {
  final String postId;
  const StreamCommentsEvent({
    required this.postId,
  });

  @override
  List<Object> get props => [postId];
}

class AddCommentsEvent extends CommentEvent {
  final String postId;
  final User user;

  final String content;
  const AddCommentsEvent({
    required this.postId,
    required this.user,
    required this.content,
  });

  @override
  List<Object> get props => [postId, user, content];
}
