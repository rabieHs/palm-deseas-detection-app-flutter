// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:palm_deseas/Features/Forum/domain/entities/comment.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/add_comment_usecase.dart';
import 'package:palm_deseas/Features/authentication/domain/entities/user.dart';
import 'package:palm_deseas/core/common/failure_handler.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/usecases/stream_post_comments_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  StreamPostCommentsUsecase commentsUsecase;
  AddCommentUsecase addCommentUsecase;
  final FailureHandler handler;
  final StreamController<List<Comment>> _streamController =
      StreamController.broadcast();
  Stream<List<Comment>> get commentStream => _streamController.stream;

  CommentBloc(
    this.addCommentUsecase,
    this.commentsUsecase,
    this.handler,
  ) : super(CommentInitial()) {
    on<CommentEvent>((event, emit) {});

    on<StreamCommentsEvent>((event, emit) async {
      final result = await commentsUsecase.call(event.postId);

      result.fold(
        (l) => emit(mapErrorCommentState(l)),
        (r) {
          r.listen((comment) {
            _streamController.add(comment);
          });

          emit(SuccessCommentState());
        },
      );
    });

    on<AddCommentsEvent>((event, emit) async {
      emit(LoadingAddCommentState());
      final comment = Comment(
          id: Uuid().v4(),
          user_id: event.user.id!,
          content: event.content,
          userName: event.user.name,
          profile_image: event.user.photo!,
          date_published: Timestamp.fromDate(DateTime.now()));

      final AddCommentParameters parameters =
          AddCommentParameters(comment: comment, postId: event.postId);
      final result = await addCommentUsecase.call(parameters);

      result.fold(
          (l) => emit(
              ErrorAddCommentState(message: handler.mapFailureToMessage(l))),
          (r) => emit(SuccessAddCommentState()));
    });
  }

  CommentState mapErrorCommentState(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OfflineCommentState(
            message: handler.mapFailureToMessage(failure));

      default:
        return ErrorCommentState(message: handler.mapFailureToMessage(failure));
    }
  }
}
