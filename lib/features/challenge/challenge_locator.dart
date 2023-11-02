import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/data/repository/challenge_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/data/rest_client/challenge_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/bloc/challenge_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/locator.dart';

class ChallengeLocator implements Locator {
  @override
  void register() {
    GetIt.I.registerLazySingleton<ChallengeBloc>(() => ChallengeBloc());
    GetIt.I.registerLazySingleton<ChallengeRestClient>(
        () => ChallengeRestClient(GetIt.I<Dio>()));
    GetIt.I.registerLazySingleton<ChallengeRepository>(
        () => ChallengeRepository());
  }

  @override
  void reset() {
    GetIt.I.resetLazySingleton<ChallengeBloc>();
  }
}
