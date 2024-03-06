part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class LoadingCreationUserState extends AuthenticationState {}

class SuccessCreationUserState extends AuthenticationState {}

class ErrorCreationUserState extends AuthenticationState {}
