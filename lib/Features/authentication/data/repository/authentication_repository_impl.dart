import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/authentication/data/models/user_model.dart';
import 'package:palm_deseas/Features/authentication/domain/repository/base_auth_repository.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:palm_deseas/core/error/exception.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:palm_deseas/core/networking/network_info.dart';

import '../../domain/entities/user.dart';
import '../datasource/remote_datasource.dart';

class AuthenticationRepositoryImpl implements BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl(this.remoteDatasource, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> createUser(CreateUserParameters user) async {
    if (await networkInfo.isConnected) {
      try {
        final _user = user.user;
        final userModel = UserModel(
            phone: _user.phone,
            id: _user.id,
            name: _user.name,
            email: _user.email,
            photo: _user.photo);
        final response =
            await remoteDatasource.createUser(userModel, user.password);
        return Right(response);
      } on ServerException catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> loginUser(
      LoginUserUsecaseParameters userParameters) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.loginUser(userParameters);
        return Right(response);
      } on WrongPasswordException {
        return Left(WrongPasswordFailure());
      } on ExistingUserException {
        return Left(ExistingUserFailure());
      } on ManyRequestsException {
        return Left(ManyRestsFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getUser();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
