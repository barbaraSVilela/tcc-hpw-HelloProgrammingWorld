import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/authentication/domain/bloc/authentication_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/locator.dart';

class AuthenticationLocator implements Locator {
  @override
  void register() {
    GetIt.I
        .registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc());
  }

  @override
  void reset() {
    GetIt.I.resetLazySingleton<AuthenticationBloc>();
  }
}
