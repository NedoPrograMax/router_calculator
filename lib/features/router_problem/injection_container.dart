import 'package:router/core/helper/shared_preferences_repository.dart';
import 'package:router/features/router_problem/data/datasources/router_problem_datasource.dart';
import 'package:router/features/router_problem/data/datasources/router_solver_datasource.dart';
import 'package:router/features/router_problem/data/repositories/router_problem_repository_impl.dart';
import 'package:router/features/router_problem/data/repositories/router_solver_repository_impl.dart';
import 'package:router/features/router_problem/domain/repositories/router_problem_repository.dart';
import 'package:router/features/router_problem/domain/repositories/router_solver_repository.dart';
import 'package:router/features/router_problem/presentation/cubits/router_problem_cubit/router_problem_cubit.dart';
import 'package:router/features/router_problem/presentation/cubits/router_solver_cubit/router_solver_cubit.dart';
import 'package:router/features/url_setter/data/datasources/url_setter_datasource.dart';
import 'package:router/features/url_setter/data/repositories/url_setter_repository_impl.dart';
import 'package:router/features/url_setter/domain/repositories/url_setter_repository.dart';
import 'package:router/features/url_setter/presentation/cubits/url_cubit/url_cubit.dart';

import 'package:router/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin RouterProblemInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();

    //Cubits
    sl.registerLazySingleton(
      () => RouterProblemCubit(repository: sl()),
    );

    sl.registerLazySingleton(
      () => RouterSolverCubit(repository: sl()),
    );

    //Repositoies
    sl.registerLazySingleton<RouterProblemRepository>(
      () => RouterProblemRepositoryImpl(
        datasource: sl(),
      ),
    );

    sl.registerLazySingleton<RouterSolverRepository>(
      () => RouterSolverRepositoryImpl(
        datasource: sl(),
      ),
    );

    //Datasources

    sl.registerLazySingleton<RouterProblemDatasource>(
      () => RouterProblemDatasourceImpl(
        dio: sl(),
      ),
    );
    sl.registerLazySingleton<RouterSolverDatasource>(
      () => RouterSolverDatasourceImpl(),
    );
  }
}
