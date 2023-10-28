import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/presentation/bloc/challenge_bloc.dart';
import 'package:tcc_hpw_hello_programming_world/locator.dart';

class ChallengeLocator implements Locator{
  @override
  void register() {
    GetIt.I.registerLazySingleton<ChallengeBloc>(() => ChallengeBloc());
  }

  @override
  void reset() {
    GetIt.I.resetLazySingleton<ChallengeBloc>();
  }

}