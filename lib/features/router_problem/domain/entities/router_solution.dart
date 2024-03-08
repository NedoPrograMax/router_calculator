import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/data/models/field_cell.dart';

abstract class RouterSolution {
  final String id;
  final List<FieldCell> steps;
  final String path;

  const RouterSolution({
    required this.id,
    required this.steps,
    required this.path,
  });

  Json toJson();
}
