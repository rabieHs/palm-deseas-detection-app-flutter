// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/Forum/data/models/post_model.dart';

import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/get_all_posts_usecase.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/stream_posts_usecase.dart';
import 'package:palm_deseas/core/common/failure_handler.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostsUsecase postsUsecase;
  final StreamPostsUsecase postsStreamUsecase;
  final FailureHandler handler;
  StreamController<List<Post>> _postController = StreamController.broadcast();

  Stream<List<Post>> get postsStream => _postController.stream;

  PostBloc(
    this.postsUsecase,
    this.postsStreamUsecase,
    this.handler,
  ) : super(PostInitial()) {
    postsStreamUsecase.call(NoParameters()).then((streamResult) {
      streamResult.fold(
          (l) => emit(ErrorPostsState(message: handler.mapFailureToMessage(l))),
          (r) => r.listen((posts) {
                _postController.add(posts);
              }));
    });

    on<GetAllPostsEvent>((event, emit) async {
      emit(LoadingPostsState());
      final result = await postsUsecase.call(NoParameters());

      result.fold(
          (l) => emit(ErrorPostsState(message: handler.mapFailureToMessage(l))),
          (r) => emit(LoadedPostsSState(posts: r)));
    });
  }
}
