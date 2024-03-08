part of 'router_problem_cubit.dart';

abstract class RouterProblemState {
  final List<RouterProblem> problems;

  RouterProblemState({required this.problems});
}

class RouterProblemInitial extends RouterProblemState {
  RouterProblemInitial() : super(problems: []);
}

class RouterProblemLoading extends RouterProblemState {
  RouterProblemLoading({required super.problems});
}

class RouterProblemData extends RouterProblemState {
  RouterProblemData({required super.problems});
}

class RouterProblemFailure extends RouterProblemState {
  final Failure failure;

  RouterProblemFailure({
    required this.failure,
    required super.problems,
  });
}

class RouterProblemAnswer extends RouterProblemState {
  final List<RouterEntity> entities;
  RouterProblemAnswer({
    required super.problems,
    required this.entities,
  });
}
