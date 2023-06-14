// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponseModel model;
  LoginLoaded({
    required this.model,
  });
}

class LoginError extends LoginState {
  final String message;
  LoginError({
    required this.message,
  });
}
