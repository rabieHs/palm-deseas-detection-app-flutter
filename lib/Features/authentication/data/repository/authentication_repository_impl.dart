import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/authentication/data/models/user_model.dart';
import 'package:palm_deseas/Features/authentication/domain/repository/base_auth_repository.dart';
import 'package:palm_deseas/core/error/exception.dart';
import 'package:palm_deseas/core/error/failure.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:palm_deseas/core/networking/network_info.dart';

import '../datasource/remote_datasource.dart';

class Authentication implements BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  Authentication(this.remoteDatasource, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> createUser(CreateUserParameters user) async {
    if (await networkInfo.isConnected) {
      try {
        final _user = user.user;
        final userModel = UserModel(
            id: _user.id,
            name: _user.name,
            email: _user.email,
            photo: _user.photo);
        await remoteDatasource.createUser(userModel, user.password);
        return const Right(unit);
      } on ServerException catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
