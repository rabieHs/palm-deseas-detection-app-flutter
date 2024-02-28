import 'package:palm_deseas/core/error/exception.dart';

import '../error/failure.dart';

class FailureHandler {
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return "Please Check your Internet Connection";
      case ServerFailure:
        return "Server Exception Please Try Again";

      default:
        return "Error getting Data";
    }
  }
}
