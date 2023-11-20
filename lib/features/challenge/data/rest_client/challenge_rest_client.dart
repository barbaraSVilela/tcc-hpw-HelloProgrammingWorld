import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

part 'challenge_rest_client.g.dart';

@RestApi()
abstract class ChallengeRestClient {
  factory ChallengeRestClient(Dio dio) = _ChallengeRestClient;

  @GET('/challenge')
  Future<Challenge> getDailyChallenge();

  @POST('/solve')
  Future<User> solveChallenge(@Query("wasSuccessful") bool wasSuccessful);
}
