import 'package:tcc_hpw_hello_programming_world/features/authentication/authentication_locator.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/challenge_locator.dart';
import 'package:tcc_hpw_hello_programming_world/features/rewards/reward_locator.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/user_locator.dart';
import 'package:tcc_hpw_hello_programming_world/services/dio/dio_locator.dart';

abstract interface class Locator {
  void register();
  void reset();
}

class LocatorService {
  static void setup() {
    ChallengeLocator().register();
    AuthenticationLocator().register();
    DioLocator().register();
    RewardLocator().register();
    UserLocator().register();
  }
}
