import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

class UploadPostUseCase extends BaseUsecase<Unit, Post> {
  final BasePostRepository repository;

  UploadPostUseCase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(Post parameters) async {
    return await repository.uploadPost(parameters);
  }
}
