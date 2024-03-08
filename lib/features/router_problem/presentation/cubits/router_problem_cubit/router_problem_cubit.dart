import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router/core/error/failures.dart';
import 'package:router/features/router_problem/domain/entities/router_answer.dart';
import 'package:router/features/router_problem/domain/entities/router_entity.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';
import 'package:router/features/router_problem/domain/repositories/router_problem_repository.dart';

part 'router_problem_state.dart';

class RouterProblemCubit extends Cubit<RouterProblemState> {
  final RouterProblemRepository repository;
  RouterProblemCubit({required this.repository})
      : super(RouterProblemInitial());

  void getProblems() async {
    emit(RouterProblemLoading(problems: state.problems));
    final result = await repository.getProblems();

    result.fold(
      (failure) => emit(RouterProblemFailure(
        failure: failure,
        problems: state.problems,
      )),
      (problems) => emit(RouterProblemData(problems: problems)),
    );
  }

  void sendSolutions(List<RouterSolution> solutions) async {
    emit(RouterProblemLoading(problems: state.problems));
    final result = await repository.sendSolutions(solutions);

    result.fold(
      (failure) => emit(RouterProblemFailure(
        failure: failure,
        problems: state.problems,
      )),
      (answers) => emit(RouterProblemAnswer(
        problems: state.problems,
        entities: _combineDataToEntities(solutions, answers),
      )),
    );
  }

  List<RouterEntity> _combineDataToEntities(
      List<RouterSolution> solutions, List<RouterAnswer> answers) {
    final entites = <RouterEntity>[];
    for (var i = 0; i < solutions.length; i++) {
      entites.add(
        RouterEntity(
          id: answers[i].id,
          field: state.problems[i].field,
          isCorrect: answers[i].isCorrect,
          steps: solutions[i].steps,
          path: solutions[i].path,
        ),
      );
    }
    return entites;
  }
}
