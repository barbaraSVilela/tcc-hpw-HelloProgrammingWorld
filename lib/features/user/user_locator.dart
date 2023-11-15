
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/data/repository/user_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/data/rest_client/user_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/presentation/bloc/user_bloc.dart';

import '../../locator.dart';

class UserLocator implements Locator {
  @override
  void register() {
    GetIt.I.registerLazySingleton<UserBloc>(() => UserBloc());
    GetIt.I.registerLazySingleton<UserRestClient>(
            () => UserRestClient(GetIt.I<Dio>()));
    GetIt.I.registerLazySingleton<UserRepository>(
            () => UserRepository());
  }

  @override
  void reset() {
    GetIt.I.resetLazySingleton<UserBloc>();
  }
}
