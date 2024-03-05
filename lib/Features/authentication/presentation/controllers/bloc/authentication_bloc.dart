import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/authentication/domain/entities/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  User? user;
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<CreateUserEvent>((event, emit) {
      User _user = User(
          email: event.email,
          name: event.name,
          phone: event.phoneNumber,
          photo: event.photo);
    });
  }
}
