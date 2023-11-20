import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

import '../../domain/entities/reward.dart';

part 'reward_rest_client.g.dart';

@RestApi()
abstract class RewardRestClient {
  factory RewardRestClient(Dio dio) = _RewardRestClient;

  @GET('/rewards')
  Future<List<Reward>> getAvailableRewards();

  @POST('/purchase')
  Future<User> purchaseReward(
    @Query("rewardId") String rewardId,
  );
}
