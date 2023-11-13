import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/data/repository/reward_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/data/rest_client/reward_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/presentation/bloc/reward_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/locator.dart';

class RewardLocator implements Locator {
  @override
  void register() {
    GetIt.I.registerLazySingleton<RewardBloc>(() => RewardBloc());
    GetIt.I.registerLazySingleton<RewardRestClient>(
        () => RewardRestClient(GetIt.I<Dio>()));
    GetIt.I.registerLazySingleton<RewardRepository>(
        () => RewardRepository());
  }

  @override
  void reset() {
    GetIt.I.resetLazySingleton<RewardBloc>();
  }
}
