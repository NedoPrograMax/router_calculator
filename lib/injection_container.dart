import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:router/core/helper/shared_preferences_repository.dart';
import 'package:router/core/interceptors/base_url_interceptor.dart';
import 'package:router/features/router_problem/injection_container.dart';
import 'package:router/features/url_setter/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class InjectionContainer extends Injector
    with UrlSetterInjector, RouterProblemInjector {}

abstract class Injector {
  @mustCallSuper
  Future<void> init() async {
    //local
    final sharedPreferences = await SharedPreferences.getInstance();

    sl.registerLazySingleton(
      () => SharedPreferencesRepository(
        sharedPreferences: sharedPreferences,
      ),
    );
    //rest
    final dio = Dio();
    dio.interceptors.addAll([
      BaseUrlInterceptor(
        sharedPreferencesRepository: sl(),
      ),
      PrettyDioLogger(),
    ]);
    dio.options = BaseOptions(headers: {'accept': 'application/json'});
    sl.registerLazySingleton(() => dio);
  }
}
