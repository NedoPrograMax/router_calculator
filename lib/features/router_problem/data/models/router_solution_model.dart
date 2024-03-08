import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';

class RouterSolutionModel extends RouterSolution {
  const RouterSolutionModel({
    required super.id,
    required super.steps,
    required super.path,
  });

  @override
  Json toJson() => {
        'id': id,
        'result': {
          'steps': steps.map((e) => e.toJson()).toList(),
          'path': path,
        },
      };
}
