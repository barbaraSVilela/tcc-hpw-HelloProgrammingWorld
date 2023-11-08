import 'package:dio/dio.dart';
import 'package:tcc_hpw_hello_programming_world/services/dio/interceptors/authentication_interceptor.dart';

class DioService {
  Dio setupDio() {
    var dio = Dio();
    dio.options =
        BaseOptions(baseUrl: 'https://hpw-backend.azurewebsites.net/api');
    dio.interceptors.add(AuthenticationInterceptor());
    return dio;
  }
}
