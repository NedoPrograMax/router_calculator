import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/data/solvers/router_solver.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/types/soultion_progress.dart';

abstract class RouterSolverDatasource {
  Stream<SolutionProgress> solveProblems(List<RouterProblem> problems);
}

class RouterSolverDatasourceImpl implements RouterSolverDatasource {
  @override
  Stream<SolutionProgress> solveProblems(List<RouterProblem> problems) {
    return RouterSolver.solveProblemsAndGetProgress(problems);
  }
}
