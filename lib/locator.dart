import 'package:tcc_hpw_hello_programming_world/features/challenge/challenge_locator.dart';

abstract interface class Locator{
  void register();
  void reset();
}

class LocatorService{
  static void setup(){
  ChallengeLocator().register();
}
}