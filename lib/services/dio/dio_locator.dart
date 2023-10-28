import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tcc_hpw_hello_programming_world/locator.dart';
import 'package:tcc_hpw_hello_programming_world/services/dio/dio_service.dart';

class DioLocator implements Locator {
  @override
  void register() {
    GetIt.I.registerLazySingleton<Dio>(() => DioService().setupDio());
  }

  @override
  void reset() {
    GetIt.I.resetLazySingleton<Dio>();
  }
}
