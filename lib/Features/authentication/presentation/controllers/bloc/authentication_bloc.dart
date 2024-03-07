import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/authentication/domain/entities/user.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/get_user_usecase.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:palm_deseas/core/common/failure_handler.dart';
import 'package:palm_deseas/core/usecase/base_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUserUsecase createUserUsecase;
  final LoginUserUsecase loginUserUsecase;
  final GetUserUsecase getUserUsecase;
  final FailureHandler handler;
  User? _user;
  User get user => _user!;
  AuthenticationBloc(this.createUserUsecase, this.loginUserUsecase,
      this.getUserUsecase, this.handler)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<CreateUserEvent>((event, emit) async {
      User _user = User(
        email: event.email,
        name: event.name,
        phone: event.phoneNumber,
      );
      final CreateUserParameters parameters =
          CreateUserParameters(user: _user, password: event.password);
      emit(LoadingCreationUserState());
      final result = await createUserUsecase.call(parameters);
      result.fold(
          (l) => emit(
              ErrorCreationUserState(message: handler.mapFailureToMessage(l))),
          (r) => emit(SuccessCreationUserState()));
    });

    on<LoginUserEvent>((event, emit) async {
      emit(LoadingLoginUserState());
      final LoginUserUsecaseParameters parameters = LoginUserUsecaseParameters(
          email: event.email, password: event.password);
      final response = await loginUserUsecase.call(parameters);
      response.fold(
          (l) => emit(
              ErrorLoginUserState(message: handler.mapFailureToMessage(l))),
          (r) => emit(SuccessLoginUserState()));
    });

    on<GetUserEvent>((event, emit) async {
      final result = await getUserUsecase.call(NoParameters());
      result.fold((l) {
        emit(ErrorGetUserUserState(message: handler.mapFailureToMessage(l)));
      }, (r) {
        _user = r;
        emit(const SuccessGetUsertate());
      });
    });
  }
}
