import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'give_help_rest_client.g.dart';

@RestApi()
abstract class GiveHelpRestClient {
  factory GiveHelpRestClient(Dio dio) = _GiveHelpRestClient;

  @POST('/help')
  Future sendHelp(
    @Query("data") String data,
    @Query("challengeId") String challengeId,
  );
}
