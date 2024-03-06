// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/authentication/domain/repository/base_auth_repository.dart';
import 'package:palm_deseas/core/error/failure.dart';

import 'package:palm_deseas/core/usecase/base_usecase.dart';

class LoginUserUsecase extends BaseUsecase<Unit, LoginUserUsecaseParameters> {
  final BaseAuthenticationRepository repository;

  LoginUserUsecase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(
      LoginUserUsecaseParameters parameters) async {
    return await repository.loginUser(parameters);
  }
}

class LoginUserUsecaseParameters {
  final String email;
  final String password;
  LoginUserUsecaseParameters({
    required this.email,
    required this.password,
  });
}
