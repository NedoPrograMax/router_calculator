import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/data/datasources/router_solver_datasource.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/repositories/router_solver_repository.dart';
import 'package:router/features/router_problem/domain/types/soultion_progress.dart';

class RouterSolverRepositoryImpl implements RouterSolverRepository {
  final RouterSolverDatasource datasource;

  RouterSolverRepositoryImpl({required this.datasource});
  @override
  Stream<SolutionProgress> solveProblems(List<RouterProblem> problems) {
    return datasource.solveProblems(problems);
  }
}
