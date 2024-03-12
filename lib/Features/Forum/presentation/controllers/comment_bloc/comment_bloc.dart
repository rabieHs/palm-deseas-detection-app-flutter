// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:palm_deseas/Features/Forum/domain/entities/comment.dart';
import 'package:palm_deseas/core/common/failure_handler.dart';
import 'package:palm_deseas/core/error/failure.dart';

import '../../../domain/usecases/stream_post_comments_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  StreamPostCommentsUsecase commentsUsecase;
  final FailureHandler handler;
  final StreamController<List<Comment>> _streamController =
      StreamController.broadcast();
  Stream<List<Comment>> get commentStream => _streamController.stream;

  CommentBloc(
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
