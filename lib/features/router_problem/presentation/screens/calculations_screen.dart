import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router/features/router_problem/domain/entities/router_entity.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/presentation/cubits/router_problem_cubit/router_problem_cubit.dart';
import 'package:router/features/router_problem/presentation/cubits/router_solver_cubit/router_solver_cubit.dart';
import 'package:router/features/router_problem/presentation/screens/answers_screen.dart';
import 'package:router/features/router_problem/presentation/widgets/calculating_loader_displayer.dart';
import 'package:router/features/router_problem/presentation/widgets/exit_to_url_button.dart';
import 'package:router/injection_container.dart';

class CalculationsScreen extends StatefulWidget {
  const CalculationsScreen({super.key});

  @override
  State<CalculationsScreen> createState() => _CalculationsScreenState();
}

class _CalculationsScreenState extends State<CalculationsScreen> {
  late final RouterProblemCubit problemsCubit;
  late final RouterSolverCubit solverCubit;
  @override
  void initState() {
    super.initState();
    problemsCubit = sl();
    solverCubit = sl()..init();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      problemsCubit.getProblems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculations"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Align(
          alignment: Alignment.center,
          child: BlocConsumer<RouterProblemCubit, RouterProblemState>(
            bloc: problemsCubit,
            listener: (context, problemsState) {
              if (problemsState is RouterProblemData) {
                solverCubit.calculateProblems(problemsState.problems);
              }
              if (problemsState is RouterProblemAnswer) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        AnswersScreen(entities: problemsState.entities),
                  ),
                );
              }
            },
            buildWhen: (previous, current) => current is! RouterProblemAnswer,
            builder: (context, problemsState) =>
                BlocBuilder<RouterSolverCubit, RouterSolverState>(
                    bloc: solverCubit,
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                            getTextBasedOnStates(problemsState, state),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (isLoaderShown(problemsState, state))
                            CalculatingLoaderDisplayer(
                              progress: state is RouterSolverCalculating
                                  ? state.currentProgress
                                  : null,
                            ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: state is RouterSolverSuccess &&
                                    (problemsState is! RouterProblemLoading ||
                                        problemsState is RouterProblemFailure)
                                ? () {
                                    problemsCubit
                                        .sendSolutions(state.solutions);
                                  }
                                : null,
                            child: const Text(
                              "Send results to the server",
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      );
                    }),
          ),
        ),
      ),
    );
  }

  String getTextBasedOnStates(
      RouterProblemState problemsState, RouterSolverState solverState) {
    if (problemsState is RouterProblemLoading &&
        solverState is RouterSolverSuccess) {
      return "Please wait for solutions to upload";
    }
    if (problemsState is RouterProblemInitial ||
        problemsState is RouterProblemLoading) {
      return "Please wait for problems to download";
    }

    if (problemsState is RouterProblemFailure) {
      return problemsState.failure.errorMessage;
    }
    if (solverState is RouterSolverCalculating ||
        solverState is RouterSolverInitial) {
      return "Please wait for solutions to calculate";
    }
    if (solverState is RouterSolverSuccess) {
      return "All calculations finished! You can send results to the server now";
    }
    if (solverState is RouterSolverFailure) {
      return solverState.failure.errorMessage;
    }
    return "";
  }

  bool isLoaderShown(
      RouterProblemState problemsState, RouterSolverState solverState) {
    if (problemsState is RouterProblemInitial ||
        problemsState is RouterProblemLoading) {
      return true;
    }
    if (solverState is RouterSolverCalculating ||
        solverState is RouterSolverInitial) {
      return true;
    }
    return false;
  }
}
