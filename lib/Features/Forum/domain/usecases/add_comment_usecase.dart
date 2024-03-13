// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

import '../entities/comment.dart';

class AddCommentUsecase extends BaseUsecase<Unit, AddCommentParameters> {
  final BasePostRepository repository;

  AddCommentUsecase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(AddCommentParameters parameters) async {
    return await repository.uploadComment(parameters);
  }
}

class AddCommentParameters {
  final Comment comment;
  final String postId;
  AddCommentParameters({
    required this.comment,
    required this.postId,
  });
}
