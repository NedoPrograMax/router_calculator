import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/domain/entities/router_answer.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';

abstract class RouterProblemRepository {
  FutureFailable<List<RouterProblem>> getProblems();

  FutureFailable<List<RouterAnswer>> sendSolutions(
      List<RouterSolution> solutions);
}
