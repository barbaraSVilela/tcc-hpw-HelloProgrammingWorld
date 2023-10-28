import 'dart:async';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.Unauthenticated()) {
    auth0 = Auth0('dev-t3p4qo2dv6qmgfte.us.auth0.com',
        'LI3ZuYZpKZLtVnYJvEiMNJtB5r2XJa3p');
    on<SignIn>(_onSignIn);
    on<SignOut>(_onSignOut);
  }

  late Auth0 auth0;

  Future<FutureOr<void>> _onSignIn(
      SignIn event, Emitter<AuthenticationState> emit) async {
    try {
      emit(const AuthenticationState.Unauthenticated());
      final credentials = await auth0.webAuthentication(scheme: 'hpw').login();

      emit(AuthenticationState.Authenticated(credentials));
    } catch (_) {
      emit(const AuthenticationState.ErrorOccurred());
    }
  }

  Future<FutureOr<void>> _onSignOut(
      SignOut event, Emitter<AuthenticationState> emit) async {
    await auth0.webAuthentication(scheme: 'hpw').logout();
    emit(const AuthenticationState.Unauthenticated());
  }
}
