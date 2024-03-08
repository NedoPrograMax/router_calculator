import 'package:dio/dio.dart';
import 'package:router/core/models/api_response.dart';
import 'package:router/features/router_problem/data/models/router_answer_model.dart';
import 'package:router/features/router_problem/data/models/router_problem_model.dart';
import 'package:router/features/router_problem/domain/entities/router_answer.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';
import 'package:router/features/router_problem/presentation/cubits/router_problem_cubit/router_problem_cubit.dart';

abstract class RouterProblemDatasource {
  Future<List<RouterProblem>> getProblems();
  Future<List<RouterAnswer>> sendSolutions(List<RouterSolution> solutions);
}

class RouterProblemDatasourceImpl implements RouterProblemDatasource {
  final Dio dio;

  RouterProblemDatasourceImpl({required this.dio});

  @override
  Future<List<RouterProblem>> getProblems() async {
    final result = await dio.get('/flutter/api');
    final response = ApiResponse.fromJson(result.data);

    final problems = List.from(response.data)
        .map((json) => RouterProblemModel.fromJson(json))
        .toList();

    return problems;
  }

  @override
  Future<List<RouterAnswer>> sendSolutions(
      List<RouterSolution> solutions) async {
    final data = solutions.map((solution) => solution.toJson()).toList();
    final result = await dio.post('/flutter/api', data: data);
    final response = ApiResponse.fromJson(result.data);

    final answers = List.from(response.data)
        .map((json) => RouterAnswerModel.fromJson(json))
        .toList();

    return answers;
  }
}
