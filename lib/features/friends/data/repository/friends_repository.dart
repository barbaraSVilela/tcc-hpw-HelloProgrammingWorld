import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/friends/data/rest_client/friends_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

class FriendsRepository {
  Future<List<User>> getFriends() {
    var client = GetIt.I<FriendsRestClient>();
    return client.getFriends();
  }

  Future acceptInvite(String inviteId) {
    var client = GetIt.I<FriendsRestClient>();
    return client.acceptInvite(inviteId);
  }

  Future sendInvite(String userId) {
    var client = GetIt.I<FriendsRestClient>();
    return client.sendInvite(userId);
  }
}
