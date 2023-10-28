part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.signIn() = SignIn;
  const factory AuthenticationEvent.signOut() = SignOut;
}
