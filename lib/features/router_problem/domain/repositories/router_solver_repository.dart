import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/types/soultion_progress.dart';

abstract class RouterSolverRepository {
  Stream<SolutionProgress> solveProblems(List<RouterProblem> problems);
}
