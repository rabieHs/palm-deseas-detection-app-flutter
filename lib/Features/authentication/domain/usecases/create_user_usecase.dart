// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:palm_deseas/Features/authentication/domain/repository/base_auth_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

import '../entities/user.dart';

class CreateUserUsecase extends BaseUsecase<Unit, CreateUserParameters> {
  final BaseAuthenticationRepository repository;

  CreateUserUsecase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(CreateUserParameters parameters) async {
    return await repository.createUser(parameters);
  }
}

class CreateUserParameters {
  final User user;
  final String password;
  const CreateUserParameters({
    required this.user,
    required this.password,
  });
}
