import 'package:dartz/dartz.dart';
import 'package:palm_deseas/core/error/failure.dart';

abstract class BaseUsecase<T, P> {
  Future<Either<Failure, T>> call(P parameters);
}

class NoParameters {
  NoParameters();
}
