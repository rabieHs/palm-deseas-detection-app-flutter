// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class ErrorCommentState extends CommentState {
  final String message;
  const ErrorCommentState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class OfflineCommentState extends CommentState {
  final String message;
  const OfflineCommentState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class SuccessCommentState extends CommentState {}
