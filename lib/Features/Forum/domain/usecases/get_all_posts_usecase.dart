// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

import '../entities/post.dart';

class GetAllPostsUsecase extends BaseUsecase<List<Post>, NoParameters> {
  final BasePostRepository postRepository;
  GetAllPostsUsecase({
    required this.postRepository,
  });
  @override
  Future<Either<Failure, List<Post>>> call(NoParameters parameters) async {
    return await postRepository.getAllPosts();
  }
}
