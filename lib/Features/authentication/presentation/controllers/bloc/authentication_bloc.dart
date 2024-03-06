import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/authentication/domain/entities/user.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/login_user_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUserUsecase createUserUsecase;
  final LoginUserUsecase loginUserUsecase;
  User? user;
  AuthenticationBloc(this.createUserUsecase, this.loginUserUsecase)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<CreateUserEvent>((event, emit) async {
      User _user = User(
          email: event.email,
          name: event.name,
          phone: event.phoneNumber,
          photo: event.photo);
      final CreateUserParameters parameters =
          CreateUserParameters(user: _user, password: event.password);
      emit(LoadingCreationUserState());
      final result = await createUserUsecase.call(parameters);
      result.fold((l) => emit(ErrorCreationUserState()),
          (r) => emit(SuccessCreationUserState()));
    });
  }
}
