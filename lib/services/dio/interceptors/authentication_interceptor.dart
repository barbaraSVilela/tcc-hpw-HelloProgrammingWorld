import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/features/authentication/domain/bloc/authentication_bloc.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var bloc = GetIt.I<AuthenticationBloc>();
    if (bloc.state is Authenticated) {
      var token = (bloc.state as Authenticated).credentials.accessToken;
      print(token);
      options.headers["Authorization"] = "Bearer $token";
    }
    return super.onRequest(options, handler);
  }
}
