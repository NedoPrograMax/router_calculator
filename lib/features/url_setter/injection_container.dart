import 'package:router/core/helper/shared_preferences_repository.dart';
import 'package:router/features/url_setter/data/datasources/url_setter_datasource.dart';
import 'package:router/features/url_setter/data/repositories/url_setter_repository_impl.dart';
import 'package:router/features/url_setter/domain/repositories/url_setter_repository.dart';
import 'package:router/features/url_setter/presentation/cubits/url_cubit/url_cubit.dart';

import 'package:router/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin UrlSetterInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();

    //Cubits
    sl.registerLazySingleton(
      () => UrlCubit(repository: sl()),
    );

    //Repositoies
    sl.registerLazySingleton<UrlSetterRepository>(
      () => UrlSetterRepositoryImpl(
        datasource: sl(),
      ),
    );

    //Datasources

    sl.registerLazySingleton<UrlSetterDatasource>(
      () => UrlSetterDatasourceImpl(
        sharedPreferencesRepository: sl(),
      ),
    );
  }
}
