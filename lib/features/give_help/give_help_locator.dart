import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/bloc/challenge_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/features/give_help/data/repository/give_help_repository.dart';
import 'package:tcc_hpw_hello_programming_world/features/give_help/data/rest_client/give_help_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/features/give_help/presentation/bloc/give_help_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/locator.dart';

class GiveHelpLocator implements Locator {
  @override
  void register() {
    GetIt.I.registerLazySingleton<GiveHelpBloc>(() => GiveHelpBloc());
    GetIt.I.registerLazySingleton<GiveHelpRestClient>(
        () => GiveHelpRestClient(GetIt.I<Dio>()));
    GetIt.I
        .registerLazySingleton<GiveHelpRepository>(() => GiveHelpRepository());
  }

  @override
  void reset() {
    GetIt.I.resetLazySingleton<ChallengeBloc>();
  }
}
