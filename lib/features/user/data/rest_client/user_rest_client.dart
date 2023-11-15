import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tcc_hpw_hello_programming_world/features/user/domain/entities/user.dart';

part 'user_rest_client.g.dart';
@RestApi()
abstract class UserRestClient {
  factory UserRestClient(Dio dio) = _UserRestClient;

  @GET('/user')
  Future<User> getUser();
}
