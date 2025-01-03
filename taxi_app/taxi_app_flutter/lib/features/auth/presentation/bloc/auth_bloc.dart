
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app_flutter/features/auth/domain/usecases/user_login.dart';

import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_event.dart';
import 'package:taxi_app_flutter/features/auth/presentation/bloc/auth_state.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final UserLoginUseCase userLogin;
  
  AuthBloc({required this.userLogin}) : super(AuthStateInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthStateLoading());
    });

    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedIn);
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
}