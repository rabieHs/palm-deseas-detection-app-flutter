// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final String email;
  final String name;
  final String password;
  final String photo;
  final String phoneNumber;
  const CreateUserEvent({
    required this.email,
    required this.name,
    required this.password,
    required this.photo,
    required this.phoneNumber,
  });
  @override
  List<Object> get props => [email, password, phoneNumber, photo];
}

class LoginUserEvent extends AuthenticationEvent {
  final String email;
  final String password;
  const LoginUserEvent({
    required this.email,
    required this.password,
  });
}

class GetUserEvent extends AuthenticationEvent {}
