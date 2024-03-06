// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class LoadingCreationUserState extends AuthenticationState {}

class SuccessCreationUserState extends AuthenticationState {}

class ErrorCreationUserState extends AuthenticationState {
  final String message;
  const ErrorCreationUserState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingLoginUserState extends AuthenticationState {}

class SuccessLoginUserState extends AuthenticationState {}

class ErrorLoginUserState extends AuthenticationState {
  final String message;
  const ErrorLoginUserState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class SuccessGetUsertate extends AuthenticationState {
  const SuccessGetUsertate();

  @override
  List<Object> get props => [];
}

class ErrorGetUserUserState extends AuthenticationState {
  final String message;

  const ErrorGetUserUserState({required this.message});
  @override
  List<Object> get props => [message];
}
