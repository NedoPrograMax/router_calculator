import 'package:router/features/router_problem/data/models/field_cell.dart';

class RouterEntity {
  final String id;
  final List<String> field;
  final bool isCorrect;
  final List<FieldCell> steps;
  final String path;

  RouterEntity({
    required this.id,
    required this.field,
    required this.isCorrect,
    required this.steps,
    required this.path,
  });
}
