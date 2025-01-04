import 'package:flutter/foundation.dart';
import 'package:taxi_app_flutter/core/entities/user.dart';

@immutable
sealed class AuthState {}

final class AuthStateInitial extends AuthState {}
final class AuthStateLoading extends AuthState {}

final class AuthStateSucess extends AuthState {
  final User user;

  AuthStateSucess(this.user);
}

final class AuthStateFailure extends AuthState {
  final String message;

  AuthStateFailure(this.message);
}

final class AuthStateConfirmationRequired extends AuthState {
  final String email;
  final String password;
  
  AuthStateConfirmationRequired({required this.email, required this.password});
}