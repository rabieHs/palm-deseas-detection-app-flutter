import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

class StreamPostsUsecase extends BaseUsecase<Stream<List<Post>>, NoParameters> {
  final BasePostRepository repository;

  StreamPostsUsecase({required this.repository});
  @override
  Future<Either<Failure, Stream<List<Post>>>> call(
      NoParameters parameters) async {
    return await repository.streamPosts();
  }
}
