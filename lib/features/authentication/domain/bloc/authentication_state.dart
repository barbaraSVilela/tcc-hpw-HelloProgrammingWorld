part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.Unauthenticated() = Unauthenticated;
  const factory AuthenticationState.ErrorOccurred() = ErrorOccurred;
  const factory AuthenticationState.Authenticated(Credentials credentials) =
      Authenticated;
}
