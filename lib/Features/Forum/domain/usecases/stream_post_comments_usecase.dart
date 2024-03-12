import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/comment.dart';
import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

class StreamPostCommentsUsecase
    extends BaseUsecase<Stream<List<Comment>>, String> {
  final BasePostRepository repository;

  StreamPostCommentsUsecase(this.repository);
  @override
  Future<Either<Failure, Stream<List<Comment>>>> call(String parameters) async {
    return await repository.streamPostComments(parameters);
  }
}
