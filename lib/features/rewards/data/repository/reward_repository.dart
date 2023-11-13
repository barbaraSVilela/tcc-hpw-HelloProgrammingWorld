import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/domain/entities/reward.dart';

import '../rest_client/reward_rest_client.dart';

class RewardRepository {
  Future<List<Reward>> getAvailableRewards() {
    var client = GetIt.I<RewardRestClient>();
    return client.getAvailableRewards();
  }
}
