// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:palm_deseas/Features/Forum/data/datasource/post_remote_datasouce.dart';
import 'package:palm_deseas/Features/Forum/data/models/comment_model.dart';
import 'package:palm_deseas/Features/Forum/data/models/post_model.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/comment.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/add_comment_usecase.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/like_post_usecase.dart';
import 'package:palm_deseas/core/error/exception.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/networking/network_info.dart';

class PostrepositoryImpl implements BasePostRepository {
  final BasePostRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;
  PostrepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDatasource.getAllPosts();

        return Right(remotePosts);
      } on ServerException catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<Post>>>> streamPosts() async {
    if (await networkInfo.isConnected) {
      final postStream = remoteDatasource.streamPosts();
      return Right(postStream);
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> likePost(
      LikePostusecaseParameters parameters) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDatasource.likePost(parameters);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<Comment>>>> streamPostComments(
      String postId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = remoteDatasource.streamPostComments(postId);
        return Right(response);
      } on ServerException catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadPost(Post post) async {
    if (await networkInfo.isConnected) {
      try {
        final postModel = PostModel(
            title: post.title,
            id: post.id,
            user_id: post.user_id,
            user_name: post.user_name,
            user_photo: post.user_photo,
            content: post.content,
            date_published: post.date_published);
        await remoteDatasource.uploadPost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadComment(
      AddCommentParameters parameters) async {
    if (await networkInfo.isConnected) {
      try {
        final CommentModel commentModel = CommentModel(
            id: parameters.comment.id,
            user_id: parameters.comment.user_id,
            content: parameters.comment.content,
            userName: parameters.comment.userName,
            profile_image: parameters.comment.profile_image,
            date_published: parameters.comment.date_published);
        await remoteDatasource.uploadComment(commentModel, parameters.postId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
