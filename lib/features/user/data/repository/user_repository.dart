import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/data/rest_client/user_rest_client.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

class UserRepository {
  Future<User> getUser() {
    var client = GetIt.I<UserRestClient>();
    return client.getUser();
  }
}