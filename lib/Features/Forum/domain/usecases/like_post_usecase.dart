// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

class LikePostusecaseParameters {
  final Post post;
  final String uid;
  LikePostusecaseParameters({
    required this.post,
    required this.uid,
  });
}

class LikePostUsecase extends BaseUsecase<Unit, LikePostusecaseParameters> {
  final BasePostRepository repository;

  LikePostUsecase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(
      LikePostusecaseParameters parameters) async {
    return await repository.likePost(parameters);
  }
}
