import 'package:router/core/error/failures.dart';
import 'package:router/core/error/repository_request_handler.dart';
import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/data/datasources/router_problem_datasource.dart';
import 'package:router/features/router_problem/domain/entities/router_answer.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';
import 'package:router/features/router_problem/domain/repositories/router_problem_repository.dart';

class RouterProblemRepositoryImpl implements RouterProblemRepository {
  final RouterProblemDatasource datasource;

  RouterProblemRepositoryImpl({required this.datasource});
  @override
  FutureFailable<List<RouterProblem>> getProblems() {
    return RepositoryRequestHandler<List<RouterProblem>>()(
        request: () => datasource.getProblems(),
        defaultFailure: ServerFailure());
  }

  @override
  FutureFailable<List<RouterAnswer>> sendSolutions(
      List<RouterSolution> solutions) {
    return RepositoryRequestHandler<List<RouterAnswer>>()(
        request: () => datasource.sendSolutions(solutions),
        defaultFailure: ServerFailure());
  }
}
