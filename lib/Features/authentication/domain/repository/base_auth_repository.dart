import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:palm_deseas/core/error/failure.dart';

import '../entities/user.dart';

abstract class BaseAuthenticationRepository {
  Future<Either<Failure, Unit>> createUser(CreateUserParameters userParameters);
  Future<Either<Failure, Unit>> loginUser(
      LoginUserUsecaseParameters userParameters);
  Future<Either<Failure, User>> getUser();
}
