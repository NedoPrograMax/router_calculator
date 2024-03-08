import 'package:router/features/router_problem/data/models/field_cell.dart';

abstract class RouterProblem {
  final String id;
  final List<String> field;
  final FieldCell startCell;
  final FieldCell endCell;

  const RouterProblem({
    required this.id,
    required this.field,
    required this.startCell,
    required this.endCell,
  });
}
