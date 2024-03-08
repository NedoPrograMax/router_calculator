part of 'router_solver_cubit.dart';

abstract class RouterSolverState {}

class RouterSolverInitial extends RouterSolverState {}

class RouterSolverCalculating extends RouterSolverState {
  final double currentProgress;

  RouterSolverCalculating({required this.currentProgress});
}

class RouterSolverSuccess extends RouterSolverState {
  final List<RouterSolution> solutions;

  RouterSolverSuccess({required this.solutions});
}

class RouterSolverFailure extends RouterSolverState {
  final Failure failure;

  RouterSolverFailure({
    required this.failure,
  });
}
