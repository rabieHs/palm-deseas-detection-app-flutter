import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/authentication/domain/entities/user.dart';
import 'package:palm_deseas/Features/authentication/domain/repository/base_auth_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

class GetUserUsecase extends BaseUsecase<User, NoParameters> {
  final BaseAuthenticationRepository repository;

  GetUserUsecase(this.repository);
  @override
  Future<Either<Failure, User>> call(NoParameters parameters) async {
    return await repository.getUser();
  }
}
