// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/Forum/data/models/post_model.dart';

import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/get_all_posts_usecase.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/like_post_usecase.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/stream_posts_usecase.dart';
import 'package:palm_deseas/Features/authentication/domain/entities/user.dart';
import 'package:palm_deseas/core/common/failure_handler.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/usecases/add_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostsUsecase postsUsecase;
  final StreamPostsUsecase postsStreamUsecase;
  final LikePostUsecase likePostUsecase;
  final FailureHandler handler;
  final UploadPostUseCase uploadPostUseCase;
  StreamController<List<Post>> _postController = StreamController.broadcast();

  Stream<List<Post>> get postsStream => _postController.stream;

  PostBloc(
    this.postsUsecase,
    this.postsStreamUsecase,
    this.handler,
    this.likePostUsecase,
    this.uploadPostUseCase,
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

    on<LikePostsEvent>((event, emit) async {
      emit(LoadingPostsState());
      final result = await likePostUsecase
          .call(LikePostusecaseParameters(post: event.post, uid: event.uid));

      result.fold(
          (l) => emit(ErrorPostsState(message: handler.mapFailureToMessage(l))),
          (r) {});
    });

    on<UploadPostEvent>((event, emit) async {
      emit(UploadingPostState());
      Post post = Post(
          title: event.title,
          id: Uuid().v4(),
          user_id: event.user.id!,
          user_name: event.user.name,
          user_photo: event.user.photo!,
          content: event.content,
          date_published: Timestamp.fromDate(DateTime.now()));
      final result = await uploadPostUseCase.call(post);
      result.fold(
          (l) => emit(
              ErrorUploadingPostState(message: handler.mapFailureToMessage(l))),
          (r) => emit(UploadedPostState("Post Successfully uploaded")));
    });
  }
}
