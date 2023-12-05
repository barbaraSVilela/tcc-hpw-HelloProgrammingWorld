import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

part 'friends_rest_client.g.dart';

@RestApi()
abstract class FriendsRestClient {
  factory FriendsRestClient(Dio dio) = _FriendsRestClient;

  @GET('/friends')
  Future<List<User>> getFriends();

  @POST('/accept-invite')
  Future acceptInvite(
    @Query("inviteId") String inviteId,
  );

  @POST('/invite')
  Future sendInvite(
    @Query("userId") String userId,
  );
}
