import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/core/error/failure.dart';

abstract class BasePostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Stream<List<Post>>>> streamPosts();
}
