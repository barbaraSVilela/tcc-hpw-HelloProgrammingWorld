import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/friends/data/repository/friends_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/friends/data/rest_client/friends_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/locator.dart';

class FriendsLocator implements Locator {
  @override
  void register() {
    GetIt.I.registerLazySingleton<FriendsRestClient>(
        () => FriendsRestClient(GetIt.I<Dio>()));
    GetIt.I.registerLazySingleton<FriendsRepository>(() => FriendsRepository());
  }

  @override
  void reset() {
    GetIt.I.resetLazySingleton<FriendsRepository>();
    GetIt.I.resetLazySingleton<FriendsRestClient>();
  }
}
