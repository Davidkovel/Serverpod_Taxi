
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/features/auth/domain/usecases/user_confirm_registration.dart';
import 'package:taxi_app_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:taxi_app_flutter/features/auth/domain/usecases/user_register.dart';

import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_event.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_state.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final UserLoginUseCase userLogin;
  final UserRegisterUseCase userRegister;
  final UserConfirmRegistrationUseCase userConfirmRegistration;
  
  AuthBloc({required this.userLogin, required this.userRegister, required this.userConfirmRegistration}) : super(AuthStateInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthStateLoading());
    });

    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedIn);
    on<AuthRegisterEvent>(_onAuthRegister);
    on<AuthConfirmRegistrationEvent>(_onAuthConfirmRegistration);
  }

  FutureOr<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());
    final result = await userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (user) => emit(AuthStateSucess(user)),
    );
  }

  FutureOr<void> _onAuthIsUserLoggedIn(AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    throw UnimplementedError();
  }

  FutureOr<void> _onAuthRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    final result = await userRegister(
      UserRegisterParams(
        email: event.email,
        password: event.password,
        username: event.username,
      ),
    );

    result.fold((failure) => emit(AuthStateFailure(failure.message)), (success) {
      if (success) {
        emit(AuthStateConfirmationRequired(email: event.email, password: event.password));
      } else {
        emit(AuthStateFailure("Could not register"));
      }
    });
  }

  FutureOr<void> _onAuthConfirmRegistration(AuthConfirmRegistrationEvent event, Emitter<AuthState> emit) async {
    final result = await userConfirmRegistration(
      UserConfirmRegistrationParams(
        email: event.email,
        verificationCode: event.verificationCode,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthStateFailure(failure.message)),
      (user) => emit(AuthStateSucess(user)),
    );
  }

  /*void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    appUserCubit.updateUser(user);
    emit(AuthStateSuccess(user));
  }*/
}