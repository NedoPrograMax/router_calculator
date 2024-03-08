import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router/core/error/failures.dart';
import 'package:router/features/router_problem/domain/entities/router_answer.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';
import 'package:router/features/router_problem/domain/repositories/router_problem_repository.dart';
import 'package:router/features/router_problem/domain/repositories/router_solver_repository.dart';

part 'router_solver_state.dart';

class RouterSolverCubit extends Cubit<RouterSolverState> {
  final RouterSolverRepository repository;
  RouterSolverCubit({required this.repository}) : super(RouterSolverInitial());

  void calculateProblems(List<RouterProblem> problems) {
    final stream = repository.solveProblems(problems);

    stream.listen(
      (event) {
        event.fold(
          (progress) =>
              emit(RouterSolverCalculating(currentProgress: progress)),
          (solutions) => emit(RouterSolverSuccess(solutions: solutions)),
        );
      },
      onError: _onError,
    );
  }

  void _onError(error, stackTrace) {
    const failure =
        Failure(errorMessage: "Something happend during calculation");
    emit(RouterSolverFailure(failure: failure));
  }

  void init() {
    emit(RouterSolverInitial());
  }
}
