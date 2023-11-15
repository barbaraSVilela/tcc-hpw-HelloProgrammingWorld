import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/data/rest_client/challenge_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

class ChallengeRepository {
  Future<Challenge> getDailyChallenge() {
    var client = GetIt.I<ChallengeRestClient>();
    return client.getDailyChallenge();
  }

  Future<User> solveDailyChallenge(bool wasSuccessful) {
    var client = GetIt.I<ChallengeRestClient>();
    return client.solveChallenge(wasSuccessful);
  }
}
