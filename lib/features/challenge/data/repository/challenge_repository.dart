import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/data/rest_client/challenge_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';

class ChallengeRepository {
  Future<Challenge> getDailyChallenge() {
    var client = GetIt.I<ChallengeRestClient>();
    return client.getDailyChallenge();
  }
}
