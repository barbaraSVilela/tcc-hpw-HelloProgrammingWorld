part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.loading() = Loading;
  const factory UserState.loaded(User user) = Loaded;
  const factory UserState.errorLoading() = ErrorLoading;

}
