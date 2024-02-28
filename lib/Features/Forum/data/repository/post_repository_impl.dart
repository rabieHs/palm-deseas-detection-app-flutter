// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:palm_deseas/Features/Forum/data/datasource/post_remote_datasouce.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/core/error/exception.dart';
import 'package:palm_deseas/core/error/failure.dart';

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
}
