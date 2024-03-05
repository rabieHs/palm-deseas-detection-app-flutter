import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:palm_deseas/core/error/failure.dart';

abstract class BaseAuthenticationRepository {
  Future<Either<Failure, Unit>> createUser(CreateUserParameters userParameters);
}
